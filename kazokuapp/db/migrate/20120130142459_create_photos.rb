class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :id
      t.belongs_to :user
      t.string :title
      t.binary :content, :limit => 1.megabyte

      t.timestamps
    end
    add_index :photos, :user_id
  end
end
