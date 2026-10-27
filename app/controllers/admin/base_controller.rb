module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :require_admin

    private

    def require_admin
      if !logged_in?
        session[:return_to] = request.fullpath
        redirect_to login_path, alert: "Войдите под аккаунтом администратора."
      elsif !current_user.admin?
        redirect_to root_path, alert: "Доступ только для администраторов."
      end
    end
  end
end
