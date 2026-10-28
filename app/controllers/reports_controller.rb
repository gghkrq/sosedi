class ReportsController < ApplicationController
  before_action :require_login
  before_action :set_listing
  before_action :forbid_own_listing

  def new
    @report = @listing.reports.build
  end

  def create
    @report = @listing.reports.build(report_params)
    @report.user = current_user

    if @report.save
      redirect_to listing_path(@listing), notice: "Жалоба отправлена. Модераторы её проверят."
    else
      render :new, status: :unprocessable_content
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def forbid_own_listing
      return unless @listing.user == current_user

      redirect_to @listing, alert: "Нельзя пожаловаться на своё объявление."
    end

    def report_params
      params.expect(report: [ :reason, :description ])
    end
end
