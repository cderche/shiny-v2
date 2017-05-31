class PaytureResponse
  include ActiveModel::Model

  attr_accessor :success, :session, :error

end
