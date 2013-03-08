class RenameContentBlocksToBlocks < ActiveRecord::Migration
  def change
    rename_table :content_blocks, :blocks
  end
end
