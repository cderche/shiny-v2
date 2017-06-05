class AddOrderToDiscountItems < ActiveRecord::Migration[5.0]
  def change
    # add_column :discount_items, :order, :reference
    add_reference :discount_items, :order, foreign_key: true
  end
end
