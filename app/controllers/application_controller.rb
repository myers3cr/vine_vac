class ApplicationController < ActionController::Base
  # Activate pundit for authorization
  include Pundit
  alias_method :current_user, :current_member
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :member_not_authorized

  private

  def member_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end