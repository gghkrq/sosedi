class RegistrationsController < ApplicationController
  layout "site"

  def new
    return redirect_to(profile_path) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    @user.terms_accepted = registration_params[:terms_accepted] == "1"

    if @user.save
      log_in(@user)
      redirect_to edit_profile_path,
                  notice: "Регистрация прошла успешно! Заполните профиль и предпочтения, чтобы найти подходящих соседей."
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def registration_params
    params.expect(user: [ :name, :email, :password, :password_confirmation, :about, :terms_accepted ])
  end
end
