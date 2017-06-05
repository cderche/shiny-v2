class AddCardIdToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :card_id, :string
  end
end
