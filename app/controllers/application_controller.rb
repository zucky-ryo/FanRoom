class ApplicationController < ActionController::Base
  before_action :configure_permit_parameter, if: :devise_controller?

  private

  def configure_permit_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, :birthday, :fan_team_id])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile, :birthday, :fan_team_id])
  end
end
