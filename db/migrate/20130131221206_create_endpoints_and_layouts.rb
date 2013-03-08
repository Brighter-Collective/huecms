class CreateEndpointsAndLayouts < ActiveRecord::Migration
  def up
    create_table :endpoints do |t|
      t.string :name
      t.string :type
      t.text :credentials

      t.timestamp
    end
  
    create_table :layouts do |t|
      t.string :name
      t.text :content

      t.timestamp
    end

    remove_index :urls, :url

    drop_table :one_columns
    drop_table :two_columns
    drop_table :urls
    # drop_table :images
    drop_table :documents
    drop_table :videos
    drop_table :pages

  end

  def down
    create_table :one_columns do |t|
      t.text :content
      t.timestamps
    end

    create_table :two_columns do |t|
      t.text :content
      t.text :left_col
      t.timestamps
    end

    create_table :urls do |t|
      t.string :url
      t.string :class_name
      t.integer :class_id
      t.timestamps
    end
    
    add_index :urls, :url, :unique => true

    create_table :images do |t|
      t.string :source_file_name
      t.integer :source_file_size
      t.string :source_content_type
      t.string :source_updated_at

      t.timestamps
    end

    create_table :documents do |t|
      t.string :source_file_name
      t.integer :source_file_size
      t.string :source_content_type
      t.string :source_updated_at

      t.timestamps
    end

    create_table :videos do |t|
      t.string :source_file_name
      t.integer :source_file_size
      t.string :source_content_type
      t.string :source_updated_at
      t.boolean :processing, :default => false

      t.timestamps
    end

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
