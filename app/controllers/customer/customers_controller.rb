class Customer::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
    @customer_new = Customer.new
    @photo_comment = PhotoComment.new
    @photos = @customer.photos.page(params[:page]).per(12) # 1ページに12個の写真を表示
    @customers = @photos.order(created_at: :desc) # 写真を最新のものから順に並び替える
  end

  def mypage
    @customer = current_customer
    @photos = @customer.photos.page(params[:page]).per(12).order(created_at: :desc) # 1ページに12個の写真を表示し、最新のものから順に並べ替える
    render 'customer/customers/mypage'
  end

  def index
    @customers = Customer.all.page(params[:page]).per(6) # 1ページに6人の会員を表示
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer # current_customer メソッドを使用してユーザーを取得
    if @customer.withdraw
      reset_session
      flash[:notice] = "退会処理を実行いたしました"
      redirect_to user_root_path
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "編集の更新に成功しました！" # 無事投稿できたら表示する記述
      redirect_to mypage_customer_customers_path(@customer)
    else
      flash[:alert] = "編集の更新に失敗しました。"
      render 'customer/customers/edit' # 編集ページにリダイレクトし、エラーメッセージを表示
    end
  end

  def toggle_favorite
    @photo = Photo.find(params[:photo_id])
    if current_customer.favorite?(@photo)
      unfavorite_photo
    else
      favorite_photo
    end
  end

  private
    def customer_params
      params.require(:customer).permit(:profile_image, :last_name, :first_name, :introduction)
    end
end
