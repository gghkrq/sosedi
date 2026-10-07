json.extract! listing, :id, :title, :description, :city, :rent, :rooms, :max_people, :user_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
