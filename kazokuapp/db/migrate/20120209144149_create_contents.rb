#coding: utf-8

class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :id

      t.belongs_to :kazoku
      t.belongs_to :user
      t.binary :data, :limit => 1.megabyte

      t.timestamps
    end
    add_index :contents, :kazoku_id
    add_index :contents, :user_id
  end
end
