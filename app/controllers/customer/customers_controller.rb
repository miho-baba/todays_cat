class Customer::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @customer_new = Customer.new
  end

  def mypage
    @photo = Photo.new
    @customer = current_customer
    @photos = Photo.where(customer_id: @customer.id)
    @photos = @customer.photos.page(params[:page]).per(5) # 1ページに5個の写真を表示
    #必要なら戻す
    #@customers = Customer.page(params[:page]).per(1)
    #@photos = Photo.all # または適切なデータベースクエリを実行してデータを取得
      render 'customer/customers/mypage'
  end

  def index
    @customers = Customer.all.page(params[:page]).per(1) # 1ページに6個の写真を表示
    @customer = current_customer
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
      params.require(:customer).permit(:profile_image, :last_name, :first_name, :introduction )
    end
end
