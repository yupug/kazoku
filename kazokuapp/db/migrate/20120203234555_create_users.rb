require 'digest/sha1'

class CreateUsers < ActiveRecord::Migration

  def change
    create_table :users do |t|
      t.integer :id
      t.string :email
      t.string :password
      t.string :name
      t.string :receive_email

      t.timestamps
    end
    add_index :users, :receive_email, :unique
  end
end
