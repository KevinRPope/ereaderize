class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :uid
      t.string :name
      t.string :gender
      t.datetime :birthdate
      t.string :hashed_password
      t.string :pwsalt
      t.string :guid
      t.integer :access_level, :default => 0
      t.boolean :confirmed_opt_in, :default => false
      t.boolean :account_inactive, :default => false
      t.string :ereader_email
      
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
