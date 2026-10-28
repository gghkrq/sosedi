class PagesController < ApplicationController
  layout "site"

  def home
    @latest_listings = Listing.active.newest.includes(:tags, user: :preference, applications: :user).limit(3)
    @cities = Listing.active.distinct.order(:city).pluck(:city)
  end
end
