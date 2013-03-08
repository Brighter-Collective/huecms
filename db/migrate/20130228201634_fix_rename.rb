class FixRename < ActiveRecord::Migration
  def change
    rename_column :images, :block_id, :content_layout_id
    add_column :endpoints, :password, :string
    add_column :endpoints, :filename, :string

  end
end
