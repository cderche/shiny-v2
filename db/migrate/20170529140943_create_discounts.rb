class CreateDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :discounts do |t|
      t.string :coupon
      t.integer :discount_type, default: 0
      t.integer :value
      t.boolean :recurring, default: false

      t.timestamps
    end
  end
end
