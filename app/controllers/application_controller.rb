class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  helper_method :current_user, :logged_in?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_not_found
    @back_url = request.referer.presence || root_path
    render "errors/not_found", status: :not_found, layout: "site"
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    return if logged_in?

    session[:return_to] = request.fullpath if request.get?
    redirect_to login_path, alert: "Сначала войдите или зарегистрируйтесь."
  end

  def log_in(user)
    return_to = session[:return_to]
    reset_session
    session[:user_id] = user.id
    @current_user = user
    return_to
  end
end
