json.extract! listing, :id, :title, :description, :city, :rent, :rooms, :max_people, :status, :user_id, :created_at, :updated_at
json.tags listing.tags.map(&:name)
json.url listing_url(listing, format: :json)
