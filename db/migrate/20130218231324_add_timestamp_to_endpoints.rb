class AddTimestampToEndpoints < ActiveRecord::Migration
  def change
    change_table(:endpoints) { |t| t.timestamps }
  end
end
