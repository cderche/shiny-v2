class AddTokenToCarts < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :token, :string
    add_index :carts, :token, unique: true
  end
end
