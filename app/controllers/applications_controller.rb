class ApplicationsController < ApplicationController
  before_action :require_login
  before_action :set_listing
  before_action :forbid_own_listing

  def new
    @application = @listing.applications.build
  end

  def create
    @application = @listing.applications.build(application_params)
    @application.user = current_user

    if @application.save
      Notification.create!(
        user: @listing.user,
        text: "#{current_user.name} откликнулся(-ась) на ваше объявление «#{@listing.title}»"
      )
      redirect_to listing_path(@listing), notice: "Отклик отправлен."
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

      redirect_to @listing, alert: "Нельзя откликнуться на своё объявление."
    end

    def application_params
      params.expect(application: [ :message ])
    end
end
