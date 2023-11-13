class Customer::PhotosController < ApplicationController
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

  def create # 写真投稿の動作の記述
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
      flash[:notice] = "写真の投稿に成功しました！"
      redirect_to customer_photo_path(@photo.id)
    else
      @customer = current_customer
      flash[:alert] = "写真の投稿に失敗しました。"
      @photos = @customer.photos.page(params[:page]).per(12)
      render 'customer/customers/mypage'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update(photo_params)
      flash[:notice] = "編集の更新に成功しました！"
      redirect_to customer_photo_path(@photo.id)
    else
      flash[:alert] = "編集の更新に失敗しました。"
      render 'customer/photos/edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to customer_photos_path
  end

  private
    def photo_params
      params.permit(:title, :image, :cat_color, :photo_introduction)
    end
end
