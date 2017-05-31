class PaymentsController < ApplicationController
  require 'payture'
  before_action :set_cart, only: [:add]

  skip_before_action :authenticate_user!, only: [:notification]
  skip_before_action :verify_authenticity_token, only: [:notification]

  def add
    puts "Host: #{ENV['PAYTURE_HOST']}"
    puts "Add: #{ENV['PAYTURE_ADD']}"

    data = {
      SessionType:  'Block'               ,
      VWUserLgn:    @cart.user.email      ,
      VWUserPsw:    'password'            ,
      OrderId:       @cart.id.to_s        ,
      Amount:       '100'
    }

    puts "data: #{data}"
    begin
      w = Payture::Wallet.new(ENV['PAYTURE_HOST'])
      response = w.init(ENV['PAYTURE_ADD'], data)
      puts "Payture: #{response}"

      respond_to do |format|
        if valid?(response)
          if @cart.update(session: response['Init']['SessionId'])
            format.html { redirect_to @cart.session_uri }
            format.js
          else
            format.html { redirect_back(fallback_location: root_path) }
            format.js
          end
        else
          case response['Init']['ErrCode']
          when 'DUPLICATE_ORDER_ID'
            format.js
            format.html { redirect_to @cart.session_uri }
          when 'WRONG_PARAMS'
            # puts "Wrong params"
            @cart.errors.add(:session, :invalid, message: 'Wrong set or format of parameters')
            format.html { redirect_back(fallback_location: root_path) }
            format.js
          end
        end
      end
    rescue REXML::ParseException => ex
      puts "Failed: #{ex.message[/^.*$/]} (#{ex.message[/Line:\s\d+/]})"
      respond_to do |format|
        @cart.errors.add(:session, :invalid, message: ex.message)
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def notification
    head :ok
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def valid?(response)
    response['Init']['Success'] == 'True' ? true : false
  end
end

# curl https://sandbox.payture.com/vwapi/Init \
# -d VWID=VWMerchantHelplingAdd \
# --data-urlencode "DATA= \
# SessionType=Add; \
# VWUserLgn=ghost@ya.ru; \
# VWUserPsw=password"
