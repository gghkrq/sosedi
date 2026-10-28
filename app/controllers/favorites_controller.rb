class FavoritesController < ApplicationController
  before_action :require_login

  def index
    @listings = current_user.favorite_listings.includes(:tags, user: :preference, applications: :user)
  end

  def create
    listing = Listing.find(params[:listing_id])
    current_user.favorites.find_or_create_by!(listing: listing)
    redirect_back fallback_location: listing, notice: "Добавлено в избранное."
  end

  def destroy
    listing = Listing.find(params[:listing_id])
    current_user.favorites.where(listing: listing).destroy_all
    redirect_back fallback_location: listing, notice: "Убрано из избранного.", status: :see_other
  end
end
