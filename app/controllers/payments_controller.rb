class PaymentsController < ApplicationController
  before_action :set_cart, only: [:add]

  skip_before_action :authenticate_user!, only: [:notification]
  skip_before_action :verify_authenticity_token, only: [:notification]

  def add
    PaytureRequest.new({ cart: @cart }).connect_card

    respond_to do |format|
      if @cart.session
        format.html { redirect_to @cart.session_uri }
        format.js
      else
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def notification
    puts "Notification received: #{notification_params.inspect}"
    pns = PaymentNotificationService.new({
      state:    notification_params[:Notification] ,
      token:    notification_params[:OrderId]      ,
      card_id:  notification_params[:CardId]
    })
    if pns.sort
      head :ok
    else
      head :bad_request
    end
  end

  private

  def set_cart
    @cart = Cart.find(params[:cart_id])
  end

  def notification_params
    dump = params.permit(:Notification, :OrderId, :CardId)
    # params.permit!
  end

end
