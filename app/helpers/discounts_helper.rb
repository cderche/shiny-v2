module DiscountsHelper

  def format_discount(discount)
    case discount.discount_type.to_sym
    when :fixed
      return number_to_currency(discount.value, locale: :ru)
    when :percentage
      return "#{discount.value}%"
    end
  end

end
