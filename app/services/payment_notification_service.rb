class PaymentNotificationService
  CUSTOMER_PAY_SUCCESS = 'CustomerPaySuccess'
  CUSTOMER_ADD_SUCCESS = 'CustomerAddSuccess'

  def initialize(attributes = {})
    puts "PaymentNotificationService.initialize"
    @state    = attributes[:state]
    @token    = attributes[:token]
    @card_id  = attributes[:card_id]
  end

  def sort
    puts "PaymentNotificationService.sort"
    puts "@state: #{@state}"
    puts "@token: #{@token}"
    case @state
    when CUSTOMER_ADD_SUCCESS
      add_success
    when CUSTOMER_PAY_SUCCESS
      pay_success
    end
  end

  private

  def add_success
    create_order if Cart.exists?(token: @token)
  end

  def pay_success
    # TODO This shouldn't be called when we add a card.
    create_order if Cart.exists?(token: @token)
  end

  def create_order
    cart = Cart.find_by(token: @token)
    @order = Order.create({
      user:           cart.user           ,
      line_items:     cart.line_items     ,
      discount_items: cart.discount_items ,
      time:           cart.start_time     ,
      date:           cart.start_date     ,
      note:           cart.note           ,
      card_id:        @card_id
    })
  end
end
