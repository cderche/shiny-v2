class Order < ApplicationRecord
  has_secure_token

  has_many :line_items, dependent: :destroy
  has_many :discount_items, dependent: :destroy
  belongs_to :user

  def convert_from_cart(cart)
    add_user_from_cart(cart)
    add_note_from_cart(cart)
    add_time_from_cart(cart)
    add_date_from_cart(cart)
    add_line_items_from_cart(cart)
    add_discount_items_from_cart(cart)
  end

  private

  def add_user_from_cart(cart)
    user = cart.user
  end

  def add_note_from_cart(cart)
    note = cart.note
  end

  def add_time_from_cart(cart)
    time = cart.start_time
  end

  def add_date_from_cart(cart)
    date = cart.start_date
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def add_discount_items_from_cart(cart)
    cart.discount_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
