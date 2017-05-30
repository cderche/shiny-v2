class CreateDiscountItems < ActiveRecord::Migration[5.0]
  def change
    create_table :discount_items do |t|
      t.references :discount, foreign_key: true
      t.belongs_to :cart, foreign_key: true

      t.timestamps
    end
  end
end
