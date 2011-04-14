class AddEreaderEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :ereader_email, :string
  end

  def self.down
    remove_column :users, :ereader_email
  end
end
