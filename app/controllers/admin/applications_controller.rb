module Admin
  class ApplicationsController < BaseController
    def index
      @applications = Application.order(created_at: :desc).includes(:user, :listing)
    end
  end
end
