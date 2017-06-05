class PaytureResponse

  CUSTOMER_PAY_SUCCESS = 'CustomerPaySuccess'

  def initialize(params)
    @state    = params['Notification']
    @card_id  = params['CardId']
    @token = params['OrderId']
  end


  def sort
    case @state
    when CUSTOMER_PAY_SUCCESS
      pay_success(params)
    end
  end

  private

  def pay_success
    # Is Cart or Order
    create_order if Cart.exists?(token: @token)
    # TODO What happens if this is related to an order.
  end

  def create_order
    ConvertToOrder.new(@token).convert
  end

end
