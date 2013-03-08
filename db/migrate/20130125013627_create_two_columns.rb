class CreateTwoColumns < ActiveRecord::Migration
  def change
    create_table :two_columns do |t|
      t.text :content
      t.text :left_col
      t.timestamps
    end
  end
end
