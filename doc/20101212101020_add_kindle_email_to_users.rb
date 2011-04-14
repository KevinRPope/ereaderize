class AddKindleEmailToUsers < ActiveRecord::Migration
  def self.up
    update_table :users do |t|
      t.string :kindle_email
    end
  end

  def self.down
    remove_column :users, :kindle_email
  end
end
