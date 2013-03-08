class ContentBlockBelongsToContent < ActiveRecord::Migration
  def up
    add_column :content_blocks, :content_id, :integer
    rename_column :content_blocks, :content, :content_data
  end

  def down
    remove_column :content_blocks, :content_id, :integer
    rename_column :content_blocks, :content_data, :content
  end
end
