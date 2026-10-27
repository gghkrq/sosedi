class ProfilesController < ApplicationController
  before_action :require_login, only: %i[ edit update ]

  def show
    if logged_in?
      @user = current_user
      render "users/show"
    else
      render :guest
    end
  end

  def edit
    @user = current_user
    @user.build_preference unless @user.preference
  end

  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to profile_path, notice: "Профиль обновлён.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def profile_params
    params.expect(user: [
      :name, :age, :city, :occupation, :about,
      preference_attributes: [ :budget, :smoking, :pets, :cleanliness, :schedule,
                               :guests, :noise, :alcohol, :remote_work, :shared_food ]
    ])
  end
end
