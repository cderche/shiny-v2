class PaymentsController < ApplicationController
  require 'payture'
  before_action :set_cart, only: [:add]

  def add
    puts "Host: #{ENV['PAYTURE_HOST']}"
    puts "Add: #{ENV['PAYTURE_ADD']}"

    data = {
      SessionType:  'Block'               ,
      VWUserLgn:    'ghost2@getshiny.ru'  ,
      VWUserPsw:    'password'            ,
      OrderId:       @cart.id.to_s        ,
      Amount:       '100'
    }

    puts "data: #{data}"

    begin
      w = Payture::Wallet.new(ENV['PAYTURE_HOST'])
      response = w.init(ENV['PAYTURE_ADD'], data)
      puts "response: #{response}"
      respond_to do |format|
        if response['Init']['Success'] == 'False'
          format.html redirect_to session_uri
          format.js { render :add, locals: { error: response['Init']['ErrCode'] } }
        else
          format.js { render :add, locals: { error: nil, uri: session_uri('Pay', response) } }
        end
      end
    rescue REXML::ParseException => ex
      puts "Failed: #{ex.message[/^.*$/]} (#{ex.message[/Line:\s\d+/]})"
      respond_to do |format|
        format.html { render :back }
        format.js { render :add, locals: { error: "Request was unsuccessful" } }
      end
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def session_uri(type, response)
    sessionId = response['Init']['SessionId']
    URI::HTTPS.build({
      host: ENV['PAYTURE_HOST'] ,
      path: "/vwapi/#{type}"        ,
      query: {
        SessionId:    sessionId
      }.to_query
    })
  end
end

# curl https://sandbox.payture.com/vwapi/Init \
# -d VWID=VWMerchantHelplingAdd \
# --data-urlencode "DATA= \
# SessionType=Add; \
# VWUserLgn=ghost@ya.ru; \
# VWUserPsw=password"
