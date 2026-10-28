module Admin
  class UsersController < BaseController
    def index
      @users = User.order(:admin, :name).includes(:listings, :applications)
    end

    def destroy
      user = User.find(params.expect(:id))
      if user == current_user
        redirect_to admin_users_path, alert: "Нельзя удалить самого себя."
      else
        user.destroy!
        redirect_to admin_users_path, notice: "Пользователь #{user.name} удалён.", status: :see_other
      end
    end
  end
end
