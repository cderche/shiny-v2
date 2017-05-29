class ChangeStartTimeToString < ActiveRecord::Migration[5.0]
  def change
    change_column :carts, :start_time, :text, default: "10:00"
    change_column :carts, :start_date, :text
  end
end
