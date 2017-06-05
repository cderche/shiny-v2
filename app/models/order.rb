class Order < ApplicationRecord
  include Calc
  has_secure_token

  has_many :line_items, dependent: :destroy
  has_many :discount_items, dependent: :destroy
  belongs_to :user

end
