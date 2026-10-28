module Admin
  class ReportsController < BaseController
    def index
      @reports = Report.order(created_at: :desc).includes(:user, :listing)
    end

    def update
      report = Report.find(params.expect(:id))
      report.update!(status: params.expect(:status))
      redirect_to admin_reports_path, notice: "Статус жалобы обновлён.", status: :see_other
    end
  end
end
