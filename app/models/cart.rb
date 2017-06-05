class Cart < ApplicationRecord
  require 'net/http'
  include Calc

  has_secure_token

  has_many :line_items, dependent: :destroy
  has_many :discount_items, dependent: :destroy
  belongs_to :user, optional: true

  before_create :set_defaults

  def add_product(product)
    current_item = line_items.find_by(product: product)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product)
    end
    current_item
  end

  def add_discount(discount)
    current_item = discount_items.find_by(discount: discount)
    unless current_item
      current_item = discount_items.build(discount: discount)
    end
    current_item
  end

  def session_uri
    return "" if session.blank?
    URI::HTTPS.build({
      host: ENV['PAYTURE_HOST'] ,
      path: "/vwapi/Pay"        ,
      query: {
        SessionId: session
      }.to_query
    })
  end

  private

  def set_defaults
    set_defaults_date
  end

  def set_defaults_date
    self.start_date = Date.today.strftime('%d/%m/%Y')
  end
end
