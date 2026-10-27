class SessionsController < ApplicationController
  def new
    return redirect_to(profile_path) if logged_in?
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password])
      return_to = log_in(user)
      redirect_to return_to || (user.admin? ? admin_root_path : profile_path)
    else
      flash.now[:alert] = "Неверная почта или пароль."
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Вы вышли из аккаунта.", status: :see_other
  end
end
