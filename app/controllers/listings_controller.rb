class ListingsController < ApplicationController
  before_action :require_login, except: %i[ index show ]
  before_action :set_listing, only: %i[ show edit update destroy ]
  before_action :require_owner, only: %i[ edit update destroy ]

  def index
    @listings = Listing.active.newest.includes(:tags, user: :preference, applications: :user)
    @listings = @listings.where(city: params[:city]) if params[:city].present?
    @listings = @listings.joins(:tags).where(tags: { name: params[:tag] }) if params[:tag].present?

    @cities = Listing.active.distinct.order(:city).pluck(:city)
    @tags = Tag.joins(:listing).merge(Listing.active)
               .group(:name).order(Arel.sql("COUNT(*) DESC")).limit(12).count.keys
  end

  def my
    @listings = current_user.listings.newest.includes(:tags, applications: :user)
  end

  # GET /listings/1
  def show
    @participant = logged_in? && @listing.residents.include?(current_user)
    @applications = @listing.applications.includes(:user) if @participant
    @reviews = @listing.user.received_reviews.includes(:author).order(created_at: :desc)
    if logged_in? && current_user != @listing.user
      @compatibility = Compatibility.new(current_user, @listing.user, @listing)
      @favorited = current_user.favorites.exists?(listing: @listing)
    end
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: "Объявление создано." }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @listing.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /listings/1
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Объявление обновлено.", status: :see_other }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @listing.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /listings/1
  def destroy
    @listing.destroy!

    respond_to do |format|
      format.html { redirect_to my_listings_path, notice: "Объявление удалено.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_listing
      @listing = Listing.find(params.expect(:id))
    end

    def listing_params
      params.expect(listing: [ :title, :description, :city, :rent, :rooms, :max_people,
                               :status, :duration, :active_until, :tag_names ])
    end

    def require_owner
      return if @listing.user == current_user

      redirect_to @listing, alert: "Это не ваше объявление."
    end
end
