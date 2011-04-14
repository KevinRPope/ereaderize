class AddArticlesCountToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :articles_count, :integer, :default => 0
  end

  def self.down
    remove_column :sites, :articles_count
  end
end