class Customer::CustomersController < ApplicationController

  def show
  end

  def mypage

  end

  def index
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        flash[:notice] = "更新成功しました！"
        redirect_to mypage_customer_customers_path
      else
        render :edit
      end
  end

  private
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :introduction )
    end
end
