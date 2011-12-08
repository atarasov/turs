class PostSymbolCount < ActiveRecord::Migration
  def self.up
      add_column :settings, :post_symbol_count, :integer, :default => 400
    end

    def self.down
      remove_column :settings, :post_symbol_count
    end

end
