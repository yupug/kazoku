class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :id
      
      t.belongs_to :kazoku
      t.belongs_to :user
      t.belongs_to :content
      t.string :title
      t.string :mime_type

      t.timestamps
    end
    add_index :photos, :kazoku_id
    add_index :photos, :user_id
    add_index :photos, :content_id
  end
end
