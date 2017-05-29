module DiscountsHelper

  def format_discount(discount)
    case discount.discount_type.to_sym
    when :fixed
      return "₽#{discount.value}"
    when :percentage
      return "#{discount.value}%"
    end
  end

end
