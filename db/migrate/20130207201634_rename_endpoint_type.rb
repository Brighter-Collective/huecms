class RenameEndpointType < ActiveRecord::Migration
  def change
    rename_column :endpoints, :type, :category
  end
end
