class Customer::SessionsController < Devise::SessionsController
  # ログインを弾く記述
  before_action :reject_inactive_user, only: [:create]

  protected

  def after_sign_in_path_for(resource)
    mypage_customer_customers_path
  end

  def after_sign_out_path_for(resource)
    user_root_path
  end

  # 利用停止の場合の記述
  def reject_inactive_user
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_customer_session_path
      end
    end
  end
end
