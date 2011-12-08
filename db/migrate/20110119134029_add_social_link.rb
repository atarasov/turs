class AddSocialLink < ActiveRecord::Migration
  def self.up
    add_column :profiles, :vkontakte_url, :string
    add_column :profiles, :odnoklassniki_url, :string
    add_column :profiles, :jj_url, :string
    add_column :profiles, :facebook_url, :string
    add_column :profiles, :twitter_url, :string
    add_column :profiles, :buzz_url, :string
    add_column :profiles, :mymir_url, :string
    add_column :profiles, :yaru_url, :string
  end

  def self.down
    remove_column :profiles, :vkontakte_url, :string
    remove_column :profiles, :odnoklassniki_url, :string
    remove_column :profiles, :jj_url, :string
    remove_column :profiles, :facebook_url, :string
    remove_column :profiles, :twitter_url, :string
    remove_column :profiles, :buzz_url, :string
    remove_column :profiles, :mymir_url, :string
    remove_column :profiles, :yaru_url, :string
  end
end
