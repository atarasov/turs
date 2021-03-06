class User < ActiveRecord::Base
  apply_simple_captcha
  concerned_with :states, :activation, :posting, :validation
  formats_attributes :bio

  belongs_to :site, :counter_cache => true
  validates_presence_of :site_id

  has_many :turs
  has_many :user_countries
  has_many :user_hotels
  belongs_to :city
  has_many :rewards
  has_many :reports
  has_many :services
  has_many :uslugis
  has_many :stends
  has_many :directions, :dependent => :delete_all
  has_many :posts, :order => "#{Post.table_name}.created_at desc"
  has_many :topics, :order => "#{Topic.table_name}.created_at desc"
  has_many :favorite_users
  has_many :preferred_users, :through => :favorite_users

  has_many :moderatorships, :dependent => :delete_all
  has_many :forums, :through => :moderatorships, :source => :forum do
    def moderatable
      select("#{Forum.table_name}.*, #{Moderatorship.table_name}.id as moderatorship_id")
    end
  end

  has_many :given_recommendations, :class_name => "Recommendation", :foreign_key => :referee_id
  has_many :recommended_users, :class_name => "User", :through => :given_recommendations

  has_many :recommendations, :foreign_key => :recommended_user_id
  has_many :referees, :class_name => "User", :through => :recommendations


  has_many :headed_teams, :class_name => "Command", :foreign_key => :leader_id
  has_many :members, :class_name => "User", :through => :headed_teams

  has_many :teams, :class_name => "Command", :foreign_key => :member_id
  has_many :leaders, :class_name => "User", :through => :teams

  has_many :favorite_users, :class_name => "Favorite", :dependent => :delete_all
  has_many :favorites, :class_name => "User", :through => :favorite_users

  has_many :monitorships, :dependent => :delete_all
  has_many :monitored_topics, :through => :monitorships, :source => :topic, :conditions => {"#{Monitorship.table_name}.active" => true}


  has_many :balances

  has_one :chat_user

  has_permalink :login, :scope => :site_id

  attr_readonly :posts_count, :last_seen_at


  scope :named_like, lambda { |name| where("users.display_name like ? or users.login like ?", "#{name}%", "#{name}%") }
  scope :online, lambda { where("users.last_seen_at >= ?", 10.minutes.ago.utc) }
  scope :random, select("*, RAND() as random_val").order("random_val")
  scope :consultant, where(true)

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :address, :price, :reestr_number, :slogan, :picture,
                  :vkontakte_url, :facebook_url, :info, :about, :phone,
                  :twitter_url, :exclus, :jj_url, :avatar, :avatar_file_name,
                  :avatar_content_type, :avatar_file_size, :avatar_updated_at,:is_hotel,
                  :is_tour_operator, :is_recreation_center,:is_sanatorium,:is_hostel,
                  :is_guide ,:is_taxi, :is_mini_hotel, :is_tur_agency, :is_user, :link_to_site,
                  :crop_h, :crop_w, :crop_x, :crop_y, :coord_long, :coord_lat, :captcha, :captcha_key, :state, :activation_code, :activated_at, :is_tour_agency
  #acts_as_authentic
  #easy_roles :roles
  has_one :profile
  has_many :journals
  has_many :comments
  has_many :posts
  has_many :raitings
  has_many :views

  #after_create :build_user_profile

  has_attached_file :avatar, :styles => {:thumbnail => "30x30#", :small => "100x100#", :large => "500x500>" }, :processors => [:cropper],
                    :url  => "/system/assets/user/avatar/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/user/avatar/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar.jpg"


  
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def avatar_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(avatar.path(style))
  end

  #validates_attachment_presence :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg']

  acts_as_commentable

  has_many :photos
  has_many :videos
  has_many :advertisements


  def build_user_profile
    self.build_profile
  end

  def add_to_balance sum, comment = nil
	self.balances.create(:sum => sum, :is_ingoing => true, :is_confirmed => true, :comment => comment.to_s)
  end

  def remove_from_balance sum, comment = nil
	self.balances.create(:sum => sum, :is_ingoing => false, :is_confirmed => true, :comment => comment.to_s)
  end

  def get_balance
	(self.balances.confirmed.ingoing.sum(:sum) - self.balances.confirmed.outgoing.sum(:sum))
  end

  class << self

    def prefetch_from(records)
      select("distinct *").where(:id => records.collect(&:user_id).uniq)
    end

    def index_from(records)
      prefetch_from(records).index_by(&:id)
    end

  end

  def available_forums
    @available_forums ||= site.ordered_forums - forums
  end

  def moderator_of?(forum)
    !!(admin? || Moderatorship.exists?(:user_id => id, :forum_id => forum.id))
  end

  def display_name
    n = read_attribute(:display_name)
    n.blank? ? login : n
  end

  alias_method :to_s, :display_name

  # this is used to keep track of the last time a user has been seen (reading a topic)
  # it is used to know when topics are new or old and which should have the green
  # activity light next to them
  #
  # we cheat by not calling it all the time, but rather only when a user views a topic
  # which means it isn't truly "last seen at" but it does serve it's intended purpose
  #
  # This is now also used to show which users are online... not at accurate as the
  # session based approach, but less code and less overhead.
  def seen!
    now = Time.now.utc
    self.class.where(:id => id).update_all(:last_seen_at => now)
    write_attribute(:last_seen_at, now)
  end

  def to_param
    id.to_s # permalink || login
  end

  def openid_url=(value)
    write_attribute :openid_url, value.blank? ? nil : OpenIdAuthentication.normalize_identifier(value)
  end

  def using_openid
    self.openid_url.blank? ? false : true
  end

#  def get_balance
#    1500
#  end

  def to_xml(options = {})
    options[:except] ||= []
    options[:except] += [:email, :login_key, :login_key_expires_at, :password_hash, :openid_url, :activated, :admin]
    super
  end


  def update_rating
	  #rating = 0
	  rating = ((self.picture.present?) ? 1 : 0)
	  rating += ((self.avatar.present?) ? 5 : 0)
	  rating += ((self.about.present?) ? 2 : 0)
	  rating += ((self.info.present?) ? 2 : 0)
	  rating += ((self.name.present?) ? 2 : 0)
	  rating += ((self.address.present?) ? 1 : 0)

	  rating += ((self.address.present?) ? 1 : 0)

	  self.photos.each do |photo|
		  rating += 1
		  rating += ((photo.description.present?) ? 0.5 : 0)
	  end

	  self.videos.each do |video|
		  rating += 1
		  rating += ((video.description.present?) ? 0.5 : 0)
	  end

	  self.comments.each do |comment|
		  if comment.commentable_type.eql?"User"
		  	rating += self.comments.count * 5
		  else
			rating += self.comments.count * 0.5
		  end
	  end

	  rating += self.journals.where(:recomended => true).count * 8
	  rating += self.services.where(:service_type => "ProAccount").count * 8
	  rating += self.services.where(:service_type => "LinkToSite").count * 15
	  if ProAccount.activated(self)
		raiting *= 1.5 if raiting
	  end
	  unless self.raiting == rating
		  self.update_attribute(:raiting, rating)
	  end

  end

  TYPE_PROFILE = [ :is_hotel => 1,
                   :is_tour_operator => 2,
                   :is_recreation_center => 3,
                   :is_sanatorium => 4,
                   :is_hostel => 5,
                   :is_guide => 6,
                   :is_taxi => 7,
                   :is_mini_hotel => 8,
                   :is_tur_agency => 9
  ]

  TYPE_PROFILE_NAME = [[1 => "Отель"],
                       [2 => "Туроператор"],
                       [3 => "База отдыха"],
                       [4 => "Санаторий"],
                       [5 => "Гостинница"],
                       [6 => "Гид"],
                       [7 => "Такси"],
                       [8 => "Мини отель"],
                       [9 => "Турагенство"]
  ]





 has_attached_file :picture, :styles => {:small => "64x64", :medium => "150x150", :thumbnail => "30x30", :card => "260x330"},
                    :url  => "/system/assets/user/picture/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/user/picture/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar.jpg"

  #validates_attachment_presence :avatar
  validates_attachment_size :picture, :less_than => 5.megabytes
  validates_attachment_content_type :picture, :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'image/pjpeg']

  def is_in_chat?
	self.chat_user.present? && (self.chat_user.last_chat_update > Time.now - 1.minute)
  end

  def login_chat
	unless self.chat_user.present?
	  self.create_chat_user
	end
	self.chat_user.update_attribute(:last_chat_update, Time.now)
  end

  def logoff_chat
	if self.chat_user.present?
	  self.chat_user.destroy
	end
  end

  private

  def reprocess_avatar
    avatar.reprocess!
  end

end
