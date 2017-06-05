json.extract! order, :id, :date, :time, :note, :user_id, :token, :created_at, :updated_at
json.url order_url(order, format: :json)
