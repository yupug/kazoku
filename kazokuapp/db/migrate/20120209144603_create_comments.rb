#coding: utf-8

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :id
      t.belongs_to :kazoku
      t.belongs_to :user
      t.belongs_to :photo
      t.text :comment

      t.timestamps
    end
    add_index :comments, :kazoku_id
    add_index :comments, :user_id
    add_index :comments, :photo_id
  end
end
