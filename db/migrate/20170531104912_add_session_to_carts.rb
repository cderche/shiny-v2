class AddSessionToCarts < ActiveRecord::Migration[5.0]
  def change
    add_column :carts, :session, :string
  end
end
