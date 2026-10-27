module Admin
  class ReviewsController < BaseController
    def index
      @reviews = Review.order(created_at: :desc).includes(:author, :recipient)
    end

    def destroy
      Review.find(params.expect(:id)).destroy!
      redirect_to admin_reviews_path, notice: "Отзыв удалён.", status: :see_other
    end
  end
end
