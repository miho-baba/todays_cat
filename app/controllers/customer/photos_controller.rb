class Customer::PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def show
    @photo = Photo.find(params[:id])
    @photo_new = Photo.new
    @customer = @photo.customer
    @photo_comment = PhotoComment.new
  end

  def index
    @photos = Photo.all.page(params[:page]).per(6).order(created_at: :desc)
    @photo = Photo.new
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
      flash[:notice] = "写真の投稿に成功しました！"
      redirect_to customer_photo_path(@photo.id)
    else
      @customer = current_customer
      flash.now[:alert] = "写真の投稿に失敗しました。"
      @photos = @customer.photos.page(params[:page]).per(12)
      render 'customer/customers/mypage'
    end
  end

  def edit
    if @photo.customer != current_customer
      flash[:alert] = "他の会員の投稿は編集できません"
      redirect_to customer_photo_path(@photo.id)
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      flash[:notice] = "編集の更新に成功しました！"
      redirect_to customer_photo_path(@photo.id)
    else
      flash.now[:alert] = "編集の更新に失敗しました。"
      render 'customer/photos/edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "投稿内容の削除に成功しました！"
    redirect_to mypage_customer_customers_path
  end

  private
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:title, :image, :cat_color, :photo_introduction)
    end
end
