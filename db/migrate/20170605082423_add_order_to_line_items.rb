class AddOrderToLineItems < ActiveRecord::Migration[5.0]
  def change
    add_column :line_items, :order, :reference
  end
end
