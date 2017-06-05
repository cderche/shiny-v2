require 'payture'

class PaytureRequest
  def initialize(params)
    @cart = params[:cart]
    @wallet = Payture::Wallet.new(ENV['PAYTURE_HOST'])
  end

  def connect_card
    block
  end

  private

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
    init(data)
  end

  def init(data)
    begin
      r = @wallet.init(ENV['PAYTURE_ADD'], data)
      rattr = attributes(r, 'Init')
      puts "rattr: #{rattr}"
      r = PaytureResponse.new(rattr)
      set_session(r)
    rescue REXML::ParseException => ex
      respond_to do |format|
        @cart.errors.add(:session, ex.message)
      end
    end
  end

  def attributes(r, type)
    {
      success:  r[type]['Success'] == 'True'  ,
      error:    r[type]['ErrCode']            ,
      session:  r[type]['SessionId']
    }
  end

  def set_session(r)
    if r.success
      @cart.update(session: r.session)
    else
      @cart.errors.add(:session, r.error)
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
