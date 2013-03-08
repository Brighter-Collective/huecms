class AddPublishedToContents < ActiveRecord::Migration
  def change
    add_column :contents, :published, :boolean, :default => 0
  end
end
