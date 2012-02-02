class CreateUsers < ActiveRecord::Migration
  def change
	drop_table :users

    create_table :users do |t|
      t.integer :id
      t.string :email
      t.string :password
      t.string :name
      t.string :receive_email

      t.timestamps
    end
  end
end
