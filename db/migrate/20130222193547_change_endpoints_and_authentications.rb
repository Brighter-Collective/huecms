class ChangeEndpointsAndAuthentications < ActiveRecord::Migration
  def change
    remove_column :authentications, :user_id
    add_column :endpoints, :authentication_id, :integer
    rename_column :endpoints, :credentials, :username
    add_column :endpoints, :address, :string
  end
end
