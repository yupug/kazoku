class CreateTimelines < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.integer :id
      t.belongs_to :kazoku
      t.belongs_to :user
      t.string :action
      t.string :object1
      t.string :object2

      t.timestamps
    end
    add_index :timelines, :kazoku_id
    add_index :timelines, :user_id
  end
end
