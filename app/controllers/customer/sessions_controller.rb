# frozen_string_literal: true

class Customer::SessionsController < Devise::SessionsController
   #ログインを弾く記述
  before_action :reject_inactive_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    mypage_customer_customers_path
  end

  def after_sign_out_path_for(resource)
    user_root_path
  end
  #利用停止の場合の記述
  def reject_inactive_user
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
        redirect_to new_customer_session_path
      end
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
