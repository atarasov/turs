class AddCountriesAttachments < ActiveRecord::Migration
  def self.up
    add_column :countries, :flag_file_name,    :string
    add_column :countries, :flag_content_type, :string
    add_column :countries, :flag_file_size,    :integer
    add_column :countries, :flag_updated_at,   :datetime

    add_column :countries, :image1_file_name,    :string
    add_column :countries, :image1_content_type, :string
    add_column :countries, :image1_file_size,    :integer
    add_column :countries, :image1_updated_at,   :datetime

    add_column :countries, :image2_file_name,    :string
    add_column :countries, :image2_content_type, :string
    add_column :countries, :image2_file_size,    :integer
    add_column :countries, :image2_updated_at,   :datetime

    add_column :countries, :image3_file_name,    :string
    add_column :countries, :image3_content_type, :string
    add_column :countries, :image3_file_size,    :integer
    add_column :countries, :image3_updated_at,   :datetime

  end

  def self.down
    remove_column :countries, :flag_file_name
    remove_column :countries, :flag_content_type
    remove_column :countries, :flag_file_size
    remove_column :countries, :flag_updated_at

    remove_column :countries, :image1_file_name
    remove_column :countries, :image1_content_type
    remove_column :countries, :image1_file_size
    remove_column :countries, :image1_updated_at

    remove_column :countries, :image2_file_name
    remove_column :countries, :image2_content_type
    remove_column :countries, :image2_file_size
    remove_column :countries, :image2_updated_at

    remove_column :countries, :image3_file_name
    remove_column :countries, :image3_content_type
    remove_column :countries, :image3_file_size
    remove_column :countries, :image3_updated_at
  end
end
