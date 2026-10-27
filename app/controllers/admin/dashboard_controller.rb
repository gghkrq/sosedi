module Admin
  class DashboardController < BaseController
    def index
      @stats = {
        "Пользователи"       => User.regular.count,
        "Объявления (всего)" => Listing.count,
        "Активные объявления" => Listing.active.count,
        "Отклики"            => Application.count,
        "Отзывы"             => Review.count,
        "Новые жалобы"       => Report.where(status: "new").count,
        "Статьи"             => Article.count
      }
      @new_users = User.regular.order(created_at: :desc).limit(5)
      @new_listings = Listing.order(created_at: :desc).includes(:user).limit(5)
      @new_applications = Application.order(created_at: :desc).includes(:user, :listing).limit(5)
      @new_reports = Report.where(status: "new").order(created_at: :desc).includes(:user, :listing)
    end
  end
end
