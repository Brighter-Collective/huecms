class CreateContent < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :page_id
      t.text :content
      t.timestamps
    end
  end
end
