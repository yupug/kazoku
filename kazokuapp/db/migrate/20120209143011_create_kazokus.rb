class CreateKazokus < ActiveRecord::Migration
  def change
    create_table :kazokus do |t|
      t.integer :id

      t.string :name

      t.timestamps
    end
  end
end
