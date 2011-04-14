class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :url
      t.string :stripped_url
      t.string :parameters
      t.references :site
      t.string :to_email
      t.integer :times_sent
      t.text :content

      t.timestamps
    end
    add_index :articles, :site_id
  end

  def self.down
    drop_table :articles
  end
end
