class ChangeUsernameToString < ActiveRecord::Migration
  def up
    change_column :endpoints, :username, :string
  end

  def down
    change_column :endpoints, :username, :text
  end
end
