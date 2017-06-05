class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :date
      t.string :time
      t.text :note
      t.belongs_to :user, foreign_key: true
      t.string :token

      t.timestamps
    end
  end
end
