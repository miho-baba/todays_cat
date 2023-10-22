class Customer::PhotosController < ApplicationController

  def show
    @photo = Photo.find(params[:id])
    @photo_new = Photo.new
    @customer = @photo.customer
    @photo_comment = PhotoComment.new
  end

  def index
  to = Time.current.at_end_of_day
  from = (to - 6.day).at_beginning_of_day
  # Photoモデルのデータを取得し、お気に入り（いいね）のカウントでソート
  @photos = Photo.includes(:favorites)
               .left_joins(:favorites)
               .where(favorites: { created_at: from...to })
               .group('photos.id')
               .order('COUNT(favorites.id) DESC')
               .page(params[:page]) # 1ページに6個の写真を表示
               .per(6)
  @photo = Photo.new
end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
    flash[:notice] = "投稿に成功しました."#無事写真投稿できたら表示する記述
      redirect_to customer_photo_path(@photo.id)
    else
      @customer = current_customer
      @photos = Photo.all
      render :index
    end
  end

  def edit
  @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.customer_id == current_customer.id
      if @photo.update(photo_params)
      flash[:notice] = "編集の更新に成功しました！"#写真の編集に成功したら表示する記述
      redirect_to customer_photo_path(@photo.id)
    else
      #render :editredirect_to customer_photo_path(@photo.id)
      render :edit
    end
    else
    flash[:error] = "編集権限がありません"
    redirect_to customer_photo_path(@photo)
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
