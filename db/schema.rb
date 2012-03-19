# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120319180623) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "advertisements", :force => true do |t|
    t.integer  "price"
    t.date     "expire_date"
    t.text     "description"
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "balances", :force => true do |t|
    t.float    "sum",          :default => 0.0
    t.integer  "user_id"
    t.boolean  "is_ingoing"
    t.boolean  "is_confirmed", :default => false
    t.string   "comment",      :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brain_busters", :force => true do |t|
    t.string "question"
    t.string "answer"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_messages", :force => true do |t|
    t.integer  "from_user_id"
    t.string   "from_guest_name"
    t.integer  "to_user_id"
    t.string   "to_guest_name"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_users", :force => true do |t|
    t.integer  "user_id"
    t.string   "guest_name"
    t.datetime "last_chat_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :default => ""
    t.string   "district",   :default => ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commands", :force => true do |t|
    t.integer  "leader_id",    :default => 0
    t.integer  "member_id",    :default => 0
    t.boolean  "is_confirmed", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "companion_advertisements", :force => true do |t|
    t.string   "title",        :default => ""
    t.integer  "days",         :default => 1
    t.integer  "from_city"
    t.string   "where",        :default => ""
    t.string   "description",  :default => ""
    t.integer  "author_type",  :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "request_type"
  end

  create_table "countries", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "meta"
    t.text     "keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flag_file_name"
    t.string   "flag_content_type"
    t.integer  "flag_file_size"
    t.datetime "flag_updated_at"
    t.string   "image1_file_name"
    t.string   "image1_content_type"
    t.integer  "image1_file_size"
    t.datetime "image1_updated_at"
    t.string   "image2_file_name"
    t.string   "image2_content_type"
    t.integer  "image2_file_size"
    t.datetime "image2_updated_at"
    t.string   "image3_file_name"
    t.string   "image3_content_type"
    t.integer  "image3_file_size"
    t.datetime "image3_updated_at"
    t.string   "country_code"
    t.integer  "review",              :default => 0
    t.integer  "rating",              :default => 0
    t.boolean  "in_list",             :default => true
  end

  create_table "directions", :force => true do |t|
    t.integer  "country_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_priority", :default => false
  end

  create_table "embassies", :force => true do |t|
    t.text     "description"
    t.text     "about"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id",     :default => 0
    t.integer  "favorite_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forums", :force => true do |t|
    t.integer "site_id"
    t.string  "name"
    t.string  "description"
    t.integer "topics_count",     :default => 0
    t.integer "posts_count",      :default => 0
    t.integer "position",         :default => 0
    t.text    "description_html"
    t.string  "state",            :default => "public"
    t.string  "permalink"
  end

  add_index "forums", ["position", "site_id"], :name => "index_forums_on_position_and_site_id"
  add_index "forums", ["site_id", "permalink"], :name => "index_forums_on_site_id_and_permalink"

  create_table "journal_photos", :force => true do |t|
    t.integer  "journal_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "category_id"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.boolean  "recomended",  :default => false
  end

  create_table "memos", :force => true do |t|
    t.text     "description"
    t.text     "about"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", :force => true do |t|
    t.string   "title",               :default => ""
    t.string   "text",                :default => ""
    t.string   "name",                :default => ""
    t.string   "page_url",            :default => ""
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profession",          :default => ""
  end

  create_table "moderatorships", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monitorships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => true
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.binary  "server_url"
    t.string  "handle"
    t.binary  "secret"
    t.integer "issued"
    t.integer "lifetime"
    t.string  "assoc_type"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.string  "nonce"
    t.integer "created"
  end

  create_table "open_id_authentication_settings", :force => true do |t|
    t.string "setting"
    t.binary "value"
  end

  create_table "photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",              :default => 0
  end

  create_table "phrasebooks", :force => true do |t|
    t.text     "description"
    t.text     "about"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_html"
    t.text     "body"
    t.integer  "forum_id"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "site_id"
  end

  add_index "posts", ["created_at", "forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["created_at", "topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["created_at", "user_id"], :name => "index_posts_on_user_id"

  create_table "profiles", :force => true do |t|
    t.text     "info"
    t.string   "address"
    t.string   "phone"
    t.string   "slogan"
    t.text     "about"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "vkontakte_url"
    t.string   "odnoklassniki_url"
    t.string   "jj_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "buzz_url"
    t.string   "mymir_url"
    t.string   "yaru_url"
    t.string   "name"
    t.integer  "review",            :default => 1
    t.integer  "raiting",           :default => 0
    t.boolean  "is_recomended",     :default => false
  end

  create_table "raitings", :force => true do |t|
    t.integer  "count"
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "journal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommendations", :force => true do |t|
    t.integer  "referee_id",          :default => 0
    t.integer  "recommended_user_id", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_photos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "news"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "report_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order",              :default => 0
  end

  create_table "reports", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.integer  "journal_id"
  end

  create_table "rewards", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.date     "expire_date"
    t.integer  "amount"
    t.boolean  "is_test"
    t.integer  "status"
    t.string   "service_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.string   "phone"
    t.string   "email"
    t.string   "addr"
    t.text     "about_text"
    t.string   "meta_title"
    t.text     "meta_description"
    t.string   "meta_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_symbol_count", :default => 400
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0
    t.integer  "users_count",  :default => 0
    t.integer  "posts_count",  :default => 0
    t.text     "description"
    t.text     "tagline"
  end

  create_table "stends", :force => true do |t|
    t.integer  "country_id"
    t.integer  "user_id"
    t.integer  "days"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenders", :force => true do |t|
    t.string   "name"
    t.integer  "type_of_holiday"
    t.integer  "catalog_id"
    t.integer  "country_id"
    t.integer  "city_id"
    t.date     "start_date"
    t.integer  "budget"
    t.text     "description"
    t.boolean  "turs"
    t.text     "contacts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_beach",             :default => false
    t.boolean  "is_exotic",            :default => false
    t.boolean  "is_therapeutic",       :default => false
    t.boolean  "is_ski",               :default => false
    t.boolean  "is_religious",         :default => false
    t.boolean  "is_business",          :default => false
    t.boolean  "is_cruise",            :default => false
    t.boolean  "is_extreme",           :default => false
    t.boolean  "is_event",             :default => false
    t.boolean  "is_agent",             :default => false
    t.boolean  "is_sanatorium",        :default => false
    t.boolean  "is_hotel",             :default => false
    t.boolean  "is_tour_operator",     :default => false
    t.boolean  "is_recreation_center", :default => false
    t.boolean  "is_mini_hotel",        :default => false
    t.boolean  "is_guesthouse",        :default => false
    t.boolean  "is_taxi",              :default => false
    t.boolean  "is_guide",             :default => false
    t.string   "contact_email",        :default => ""
    t.string   "contact_icq",          :default => ""
    t.string   "contact_phone",        :default => ""
    t.string   "contact_skype",        :default => ""
  end

  create_table "tiny_prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tiny_videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",            :default => 0
    t.integer  "sticky",          :default => 0
    t.integer  "posts_count",     :default => 0
    t.boolean  "locked",          :default => false
    t.integer  "last_post_id"
    t.datetime "last_updated_at"
    t.integer  "last_user_id"
    t.integer  "site_id"
    t.string   "permalink"
  end

  add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"
  add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_forum_id_and_last_updated_at"
  add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"

  create_table "turs", :force => true do |t|
    t.string   "title"
    t.integer  "stars"
    t.integer  "price"
    t.integer  "user_id"
    t.integer  "country_id"
    t.boolean  "is_recomended"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_countries", :force => true do |t|
    t.integer  "country_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_hotels", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_photos", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "image_file_size"
    t.string   "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_videos", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.string   "video_file_size"
    t.string   "video_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                   :default => "",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
    t.string   "salt",                      :limit => 40
    t.string   "openid_url"
    t.datetime "activated_at"
    t.text     "bio_html"
    t.datetime "remember_token_expires_at"
    t.string   "crypted_password",          :limit => 40
    t.datetime "last_seen_at"
    t.datetime "deleted_at"
    t.boolean  "admin",                                   :default => false
    t.string   "activation_code",           :limit => 40
    t.integer  "posts_count",                             :default => 0
    t.string   "website"
    t.string   "remember_token"
    t.string   "display_name"
    t.string   "bio"
    t.datetime "last_login_at"
    t.string   "login"
    t.integer  "site_id"
    t.string   "state",                                   :default => "passive"
    t.boolean  "is_hotel",                                :default => false
    t.boolean  "is_tour_operator",                        :default => false
    t.boolean  "is_recreation_center",                    :default => false
    t.boolean  "is_sanatorium",                           :default => false
    t.boolean  "is_hostel",                               :default => false
    t.boolean  "is_guide",                                :default => false
    t.boolean  "is_taxi",                                 :default => false
    t.boolean  "is_mini_hotel",                           :default => false
    t.boolean  "is_user",                                 :default => true
    t.string   "twitter_url"
    t.string   "facebook_url"
    t.string   "jj_url"
    t.string   "vkontakte_url"
    t.string   "reestr_number"
    t.string   "price"
    t.string   "slogan"
    t.string   "phone"
    t.string   "exclus"
    t.string   "address"
    t.string   "name"
    t.text     "about"
    t.text     "info"
    t.float    "raiting",                                 :default => 0.0
    t.integer  "review",                                  :default => 0
    t.boolean  "is_recomended",                           :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "is_tour_agency",                          :default => false
    t.integer  "city_id",                                 :default => 0
    t.string   "link_to_site",                            :default => " "
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "coord_long"
    t.string   "coord_lat"
    t.string   "icq"
    t.string   "skype"
    t.string   "classmates_url"
    t.string   "google_buzz_url"
    t.string   "my_mail_url"
    t.string   "ya_ru_url"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["last_seen_at"], :name => "index_users_on_last_seen_at"
  add_index "users", ["site_id", "permalink"], :name => "index_site_users_on_permalink"
  add_index "users", ["site_id", "posts_count"], :name => "index_site_users_on_posts_count"

  create_table "uslugis", :force => true do |t|
    t.integer  "val"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "code"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "views", :force => true do |t|
    t.integer  "count"
    t.integer  "user_id"
    t.integer  "country_id"
    t.integer  "journal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visas", :force => true do |t|
    t.text     "description"
    t.text     "about"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
