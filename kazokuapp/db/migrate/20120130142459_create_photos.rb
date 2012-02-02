class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :id
      t.belongs_to :user
      t.binary :content
      t.string :desc

      t.timestamps
    end
    add_index :photos, :user_id
  end
end
