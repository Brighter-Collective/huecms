class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.string  :name
      t.text    :content
      t.integer :endpoint_id
      t.integer :layout_id
      t.timestamps
    end

    drop_table :contents

    create_table :contents do |u|
      u.string  :name
      u.integer :folder_id
      u.timestamps
    end

  end
end
