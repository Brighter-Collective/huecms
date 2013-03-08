class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :source_file_name
      t.integer :source_file_size
      t.string :source_content_type
      t.string :source_updated_at

      t.timestamps
    end
  end
end
