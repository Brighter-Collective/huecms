class AddTypeToLayouts < ActiveRecord::Migration
  def change
    add_column :layouts, :type, :string
  end
end
