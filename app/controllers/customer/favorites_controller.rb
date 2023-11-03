class Customer::FavoritesController < ApplicationController
  #いいねボタンの記述

  def index
    @favorites = current_customer.favorites.includes(:photo).order("photos.created_at DESC")# 写真を最新のものから順に並び替える
    @photos = @favorites.map { |favorite| favorite.photo }
    @photos = Kaminari.paginate_array(@photos).page(params[:page]).per(9)# 1ページに9個の写真を表示
  end

  def create
    @photo = Photo.find(params[:photo_id])
    favorite = @photo.favorites.new(customer_id: current_customer.id)
    favorite.save
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    favorite = current_customer.favorites.find_by(photo_id: @photo.id)
    favorite.destroy
  end

end
