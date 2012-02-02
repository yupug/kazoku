class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string :to
      t.string :from
      t.string :title
      t.binary :attachment, :limit => 5.megabyte
      t.integer :is_imported

      t.timestamps
    end
  end
end
