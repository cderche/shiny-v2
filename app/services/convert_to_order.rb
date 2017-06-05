class ConvertToOrder

  def initialize(token)
    @cart = Cart.find_by(token: token)
  end

  def convert
    @order = Order.new
    @order.convert_from_cart(@cart)
    @order.save
  end

end
