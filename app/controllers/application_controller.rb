class ApplicationController < ActionController::Base
  before_action :configure_permit_parameter, if: :devise_controller?

  private

  def configure_permit_parameter
    # ユーザー登録時のストロングパラメータ
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :profile, :birthday, :fan_team_id])
    # ユーザー編集時のストロングパラメータ
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :profile, :birthday, :fan_team_id])
  end

  # ログイン後、マイページに遷移させる
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
end
