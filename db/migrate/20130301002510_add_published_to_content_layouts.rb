class AddPublishedToContentLayouts < ActiveRecord::Migration
  def change
    add_column :content_layouts, :published, :boolean
  end
end
