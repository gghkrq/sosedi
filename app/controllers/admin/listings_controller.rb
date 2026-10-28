module Admin
  class ListingsController < BaseController
    def index
      @listings = Listing.order(created_at: :desc).includes(:user, :applications, :reports)
    end

    def destroy
      listing = Listing.find(params.expect(:id))
      listing.destroy!
      redirect_to admin_listings_path, notice: "Объявление «#{listing.title}» удалено.", status: :see_other
    end
  end
end
