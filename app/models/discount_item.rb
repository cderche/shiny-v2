class DiscountItem < ApplicationRecord
  belongs_to :discount
  belongs_to :cart
  belongs_to :order, optional: true

  def real_value
    # puts "discount.discount_type: #{discount.discount_type}"
    case discount.discount_type.to_sym
    when :fixed
      return discount.value
    when :percentage
      return discount.value / 100.0 * cart.sub_total
    end
  end

end
