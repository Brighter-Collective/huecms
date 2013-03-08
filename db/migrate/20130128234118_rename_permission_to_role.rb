class RenamePermissionToRole < ActiveRecord::Migration
  def change
    rename_column :users, :permission, :role
    User.reset_column_information
  end
end
