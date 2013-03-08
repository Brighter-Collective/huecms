class AddTypeToEndpoints < ActiveRecord::Migration
  def change
    add_column :endpoints, :type, :string
  end
end
