class AddTimestampToLayouts < ActiveRecord::Migration
  def change
    change_table(:layouts) { |t| t.timestamps }
  end
end
