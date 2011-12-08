class AddUserOptions < ActiveRecord::Migration
  def self.up
    add_column :users, :twitter_url, :string
    add_column :users, :facebook_url, :string
    add_column :users, :jj_url, :string
    add_column :users, :vkontakte_url, :string
    add_column :users, :reestr_number, :string
    add_column :users, :price, :string
    add_column :users, :slogan, :string
    add_column :users, :phone, :string
    add_column :users, :exclus, :string
    add_column :users, :address, :string
    add_column :users, :name, :string
    add_column :users, :about, :text
    add_column :users, :info, :text
    add_column :users, :raiting, :integer, :default => 0
    add_column :users, :review, :integer, :default => 0
    add_column :users, :is_recomended, :boolean, :default => false
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime

  end

  def self.down
    remove_column :users, :twitter_url
    remove_column :users, :facebook_url
    remove_column :users, :jj_url
    remove_column :users, :vkontakte_url
    remove_column :users, :reestr_number
    remove_column :users, :phone
    remove_column :users, :exclus
    remove_column :users, :address
    remove_column :users, :slogan
    remove_column :users, :price
    remove_column :users, :info
    remove_column :users, :name
    remove_column :users, :about
    remove_column :users, :raiting
    remove_column :users, :review
    remove_column :users, :is_recomended
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
  end
end
