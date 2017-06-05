class AddOrderToLineItems < ActiveRecord::Migration[5.0]
  def change
    # add_column :line_items, :order, :reference
    add_reference :line_items, :order, foreign_key: true
  end
end
