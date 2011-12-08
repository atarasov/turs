class User < ActiveRecord::Base
  concerned_with :states, :activation, :posting, :validation
  formats_attributes :bio

  belongs_to :site, :counter_cache => true
  validates_presence_of :site_id

  has_many :turs
  has_many :directions
  has_many :posts, :order => "#{Post.table_name}.created_at desc"
  has_many :topics, :order => "#{Topic.table_name}.created_at desc"

  has_many :moderatorships, :dependent => :delete_all
  has_many :forums, :through => :moderatorships, :source => :forum do
    def moderatable
      select("#{Forum.table_name}.*, #{Moderatorship.table_name}.id as moderatorship_id")
    end
  end

  has_many :monitorships, :dependent => :delete_all
  has_many :monitored_topics, :through => :monitorships, :source => :topic, :conditions => {"#{Monitorship.table_name}.active" => true}

  has_permalink :login, :scope => :site_id

  attr_readonly :posts_count, :last_seen_at


  scope :named_like, lambda { |name| where("users.display_name like ? or users.login like ?", "#{name}%", "#{name}%") }
  scope :online, lambda { where("users.last_seen_at >= ?", 10.minutes.ago.utc) }


  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :address, :price, :reestr_number, :slogan,
                  :vkontakte_url, :facebook_url, :info, :about, :phone,
                  :twitter_url, :exclus, :jj_url, :avatar, :avatar_file_name,
                  :avatar_content_type, :avatar_file_size, :avatar_updated_at,:is_hotel,
                  :is_tour_operator, :is_recreation_center,:is_sanatorium,:is_hostel,
                  :is_guide ,:is_taxi, :is_mini_hotel, :is_tur_agency, :is_user
  #acts_as_authentic
  #easy_roles :roles
  has_one :profile
  has_many :journals
  has_many :comments
  has_many :posts
  has_many :raitings
  has_many :views

  #after_create :build_user_profile

  has_attached_file :avatar, :styles => {:small => "64x64", :medium => "150x150", :thumbnail => "30x30"},
                    :url  => "/system/assets/user/avatar/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/assets/user/avatar/:id/:style/:basename.:extension",
                    :default_url => "/images/avatar.jpg"

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

  def to_xml(options = {})
    options[:except] ||= []
    options[:except] += [:email, :login_key, :login_key_expires_at, :password_hash, :openid_url, :activated, :admin]
    super
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
end
