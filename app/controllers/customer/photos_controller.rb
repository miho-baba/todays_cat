class Customer::PhotosController < ApplicationController

  def show
  @photo = Photo.find(params[:id])
  @photo_new = Photo.new
  @customer = @photo.customer
  end

  def index
    @photos = Photo.all
  end

  def edit
    @photo = Photo.find(params[:id])
  if @photo.customer == current_customer
    render :edit
  else
  redirect_to edit_customer_photo_path
  end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
    flash[:notice] = "投稿に成功しました."
    redirect_to customer_photo_path(@photo.id)
    else
      @customer = current_customer
      @photos = Photo.all
      render :index
    end
  end

  def update
    @photo = Photo.find(params[:id])
    @photo.customer_id = current_customer.id
    if @photo.update(photo_params)
      flash[:notice] = "更新が成功しました！"
      redirect_to customer_photo_path(@photo.id)
    else
      render :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to customer_photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :image, :cat_color, :photo_introduction)
  end
end
