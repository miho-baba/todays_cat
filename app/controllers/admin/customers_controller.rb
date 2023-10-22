class Admin::CustomersController < ApplicationController

  def index
    #ページネーションの記述
    @customers = Customer.page(params[:page]).per(6)# 1ページに6人の会員を表示
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    flash[:notice] = "編集の更新に成功しました！"#無事編集できたら表示する記述
    redirect_to admin_customer_path(customer.id)
  end

  private

  def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :email, :is_deleted)
  end

end
