class UrlUnique < ActiveRecord::Migration
  def up
    add_index :urls, :url, :unique => true
  end

  def down
    remove_index :urls, :url, :unique => true
  end
end