class CreateCarts < ActiveRecord::Migration[5.0]
  def change
    create_table :carts do |t|
      t.date :start_date
      t.time :start_time
      t.text :note

      t.timestamps
    end
  end
end
