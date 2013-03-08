class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :url
      t.integer :user_id
      t.string :view
      t.boolean :active
      t.integer :reviewer_id
      t.string :reviewer_comment
      t.timestamps
    end
  end
end
