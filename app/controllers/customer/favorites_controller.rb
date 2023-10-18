class Customer::FavoritesController < ApplicationController
  #いいねボタンの記述
  def create
    @photo = Photo.find(params[:photo_id])
    favorite = @photo.favorites.new(customer_id: current_customer.id)
    favorite.save
    if params[:index] == "true"
      redirect_to customer_photos_path
    elsif params[:index] == "false"
       redirect_to customer_photo_path(@photo)
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    favorite = current_customer.favorites.find_by(photo_id: @photo.id)
    favorite.destroy
     if params[:index] == "true"
      redirect_to customer_photos_path
     elsif params[:index] == "false"
       redirect_to customer_photo_path(@photo)
     end
  end

end
