class ChangeContentDataToData < ActiveRecord::Migration
  def change
    rename_column :blocks, :content_data, :data
  end
end
