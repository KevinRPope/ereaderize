class Removetables < ActiveRecord::Migration
  def self.up
    drop_table :users
    drop_table :admins
  end

  def self.down
    #re-run devise migrations if you want this undone
  end
end
