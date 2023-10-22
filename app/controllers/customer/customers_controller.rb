class Customer::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
    @customer_new = Customer.new
  end

  def mypage
    @photo = Photo.new
    @customer = current_customer
    @photos = Photo.where(customer_id: @customer.id)
    @photos = @customer.photos.page(params[:page]).per(12) # 1ページに12個の写真を表示
    #必要なら戻す
    #@customers = Customer.page(params[:page]).per(1)
    #@photos = Photo.all # または適切なデータベースクエリを実行してデータを取得
      render 'customer/customers/mypage'
  end

  def index
    @customers = Customer.all.page(params[:page]).per(6) # 1ページに6人の会員を表示
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        flash[:notice] = "編集の更新に成功しました！"#無事投稿できたら表示する記述
        redirect_to mypage_customer_customers_path(@customer)
      else
        #render :edit
        flash[:alert] = "編集の更新に失敗しました。"
        render 'customer/customers/edit' # 編集ページにリダイレクトし、エラーメッセージを表示
      end
  end

  private
    def customer_params
      params.require(:customer).permit(:profile_image, :last_name, :first_name, :introduction )
    end
end
