json.extract! cart, :id, :start_date, :start_time, :note, :created_at, :updated_at
json.url cart_url(cart, format: :json)
