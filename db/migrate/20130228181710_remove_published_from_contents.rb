class RemovePublishedFromContents < ActiveRecord::Migration
  def change
    remove_column :contents, :published
  end
end
