require 'payture'

class PaytureRequest
  def initialize(params)
    @cart = params[:cart]
    @order = params[:order]
    @wallet = Payture::Wallet.new(ENV['PAYTURE_HOST'])
  end

  def connect_card
    block
  end

  def charge
    data = {
      VWUserLgn:    @order.user.email       ,
      VWUserPsw:    'password'              ,
      OrderId:      @order.token            ,
      # Amount:       @order.amount_to_charge ,
      Amount:       100 ,
      CardId:       @order.card_id
    }
    puts "data: #{data}"
    pay(data, @order)
  end

  private

  def pay(data, obj)
    begin
      r = @wallet.pay(ENV['PAYTURE_PAY'], data)
      puts "r: #{r.inspect}"
      rattr = attributes(r, 'Pay')
      r = PaytureResponse.new(rattr)
      obj.update(charged_at: DateTime.now) if r.success
    rescue REXML::ParseException => ex
      puts "ERROR: #{ex.message}"
      obj.errors.add(:session, ex.message)
    end
  end

  def block
    data = {
      SessionType:  'Block'           ,
      VWUserLgn:    @cart.user.email  ,
      VWUserPsw:    'password'        ,
      OrderId:      @cart.token       ,
      Amount:       100               ,
      Url:          callback_url
    }
    puts "data #{data}"
    init(ENV['PAYTURE_ADD'], data, @cart)
  end

  def init(merchant, data, obj)
    begin
      r = @wallet.init(merchant, data)
      rattr = attributes(r, 'Init')
      puts "rattr: #{rattr}"
      r = PaytureResponse.new(rattr)
      set_session(r, obj)
    rescue REXML::ParseException => ex
      obj.errors.add(:session, ex.message)
    end
  end

  def attributes(r, type)
    {
      success:  r[type]['Success'] == 'True'  ,
      error:    r[type]['ErrCode']            ,
      session:  r[type]['SessionId']
    }
  end

  def set_session(r, obj)
    if r.success
      obj.update(session: r.session)
    else
      obj.errors.add(:session, r.error)
    end
  end

  def callback_url
    URI::HTTP.build({
      host: ENV['DOMAIN']   ,
      port: ENV['PORT']     ,
      path: "/result"       ,
      query: {
        token: @cart.token
      }.to_query
    }).to_s
  end
end
