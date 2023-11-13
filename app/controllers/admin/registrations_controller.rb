class Admin::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    admin_mypage_path
  end

  protected
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end
end
