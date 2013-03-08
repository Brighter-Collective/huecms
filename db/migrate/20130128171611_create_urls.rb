class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :class_name
      t.integer :class_id
      t.timestamps
    end
  end
end