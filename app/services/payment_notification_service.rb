class PaymentNotificationService
  CUSTOMER_PAY_SUCCESS = 'CustomerPaySuccess'

  def initialize(attributes = {})
    puts "PaymentNotificationService.initialize"
    @state = attributes[:state]
    @token = attributes[:token]
  end

  def sort
    puts "PaymentNotificationService.sort"
    puts "@state: #{@state}"
    puts "@token: #{@token}"
    case @state
    when CUSTOMER_PAY_SUCCESS
      pay_success
    end
  end

  private

  def pay_success
    puts "PaymentNotificationService.pay_success"
    create_order if Cart.exists?(token: @token)
    # TODO What happens if this is related to an order.
  end

  def create_order
    cart = Cart.find_by(token: @token)
    @order = Order.create({
      user:           cart.user           ,
      line_items:     cart.line_items     ,
      discount_items: cart.discount_items ,
      time:           cart.start_time     ,
      date:           cart.start_date     ,
      note:           cart.note
    })
  end
end
