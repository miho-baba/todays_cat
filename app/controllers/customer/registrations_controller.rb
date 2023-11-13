class Customer::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, if: :devise_controller?

  def after_sign_in_path_for(resource)
    mypage_customer_customers_path
  end

  protected
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number])
    end
end
