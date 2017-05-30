class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :discount_items, dependent: :destroy
  belongs_to :user, optional: true

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

  def add_discount(discount)
    current_item = discount_items.find_by(discount: discount)
    unless current_item
      current_item = discount_items.build(discount: discount)
    end
    current_item
  end

  def sub_total
    line_items.to_a.sum { |i| i.total_price }
  end

  def discount_total
    discount_items.to_a.sum { |i| i.real_value }
  end

  def total
    sub_total - discount_total
  end

  private

  def set_defaults
    set_defaults_date
  end

  def set_defaults_date
    self.start_date = Date.today.strftime('%d/%m/%Y')
  end
end
