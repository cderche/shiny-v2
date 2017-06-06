class AddChargedAtToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :charged_at, :DateTime
  end
end
