class Customer::MypagesController < ApplicationController

# before_action :set_customer, only: [:show]

  def show
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
      if @customer.id == current_customer.id
        flash[:notice] = "編集の更新に成功しました！"#無事編集できたら表示する記述
        render :edit
      else
        redirect_to customer_mypage_path(current_customer)
      end
  end

  def update
  @customer = Customer.find(params[:id])
  end
  # 必要ならコメントアウトをはずすprivate

  # def set_customer
  #   @customer = Customer.find([:id])
  # end
end
