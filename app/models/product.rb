class Product < ApplicationRecord
  enum category: [:room, :option, :material]

  validates :title    , presence: true
  validates :price    , presence: true
  validates :category , presence: true
  
end
