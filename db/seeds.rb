# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.create!(title: 'Livingroom'   , price: 800, category: :room)
Product.create!(title: 'Kitchen'      , price: 600, category: :room)
Product.create!(title: 'Bedrooms'     , price: 600, category: :room)
Product.create!(title: 'Bathrooms'    , price: 600, category: :room)
Product.create!(title: 'Custom Time'  , price: 400, category: :room)
Product.create!(title: 'Windows'      , price: 200, category: :option)
Product.create!(title: 'Ironing'      , price: 50, category: :option)
Product.create!(title: 'Oven'         , price: 300, category: :option)
Product.create!(title: 'Fridge'       , price: 400, category: :option)
Product.create!(title: 'Cabinets'     , price: 400, category: :option)
Product.create!(title: 'Chemicals'    , price: 1000, category: :material)
Product.create!(title: 'Utensils'     , price: 1000, category: :material)
