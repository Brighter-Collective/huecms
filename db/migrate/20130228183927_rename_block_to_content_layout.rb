class RenameBlockToContentLayout < ActiveRecord::Migration
  def up
    rename_table :blocks, :content_layouts
  end

  def down
    rename_table :content_layouts, :blocks
  end
end
