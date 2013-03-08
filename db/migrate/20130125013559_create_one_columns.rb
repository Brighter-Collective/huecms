class CreateOneColumns < ActiveRecord::Migration
  def change
    create_table :one_columns do |t|
      t.text :content
      t.timestamps
    end
  end
end
