class Order < ApplicationRecord
  include Calc
  has_secure_token

  has_many :line_items, dependent: :destroy
  has_many :discount_items, dependent: :destroy
  has_many :discounts, through: :discount_items
  belongs_to :user

  def amount_to_charge
    total * 100
  end

  def charged?
    charged_at?
  end

  def recurring?
    discounts.exists?(recurring: true)
  end

end
