class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  before_create :set_defaults

  def add_product(product)
    current_item = line_items.find_by(product: product)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product)
    end
    current_item
  end

  def sub_total
    line_items.to_a.sum { |i| i.total_price }
  end

  private

  def set_defaults
    set_defaults_date
  end

  def set_defaults_date
    self.start_date = Date.today.strftime('%d/%m/%Y')
  end
end
