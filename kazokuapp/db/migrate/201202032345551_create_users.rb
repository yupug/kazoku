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
    
    User.create(
      :id => 1, :email => 'aiueo@gmail.com',
      :password => 'pass', :name => 'あいうえお',
      :receive_email => 'post-images-dev@kazoku.mailgun.org'
    )

    User.create(
      :id => 2, :email => 'kakikukeko@gmail.com',
      :password => 'pass', :name => 'かきくけこ'
    )

    User.create(
      :id => 3, :email => 'sasisuseso@gmail.com',
      :password => 'pass', :name => 'さしすせそ'
    )

  end
end
