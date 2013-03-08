class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :block_id
      t.string :content_tag_name
      t.string :source_file_name
      t.string :source_content_type
      t.string :source_file_size
      t.timestamps
    end
  end
end
