class CreateContentLayoutEndpoints < ActiveRecord::Migration
  def change
    create_table :content_layout_endpoints do |t|
      t.integer :content_layout_id
      t.integer :endpoint_id
      t.timestamps
    end
  end
end
