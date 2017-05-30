module DiscountItemsHelper

  def present_discount(discount_item)
    case discount_item.discount.discount_type.to_sym
    when :fixed
      return number_to_currency(discount_item.discount.value, locale: :ru)
    when :percentage
      return "#{discount_item.discount.value} %"
    end
  end

end
