#coding: utf-8

class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.integer :id
      
      t.belongs_to :kazoku
      t.string :email
      t.string :password
      t.string :name
      t.string :receive_email

      t.timestamps
    end
    add_index :users, :kazoku_id
    add_index :users, :email, :unique
    add_index :users, :receive_email, :unique
  end
end
