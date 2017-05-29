class Product < ApplicationRecord
  enum category: [:room, :option, :material]
end
