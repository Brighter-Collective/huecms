class AddPathToEndpoints < ActiveRecord::Migration
  def change
    add_column :endpoints, :path, :string
  end
end
