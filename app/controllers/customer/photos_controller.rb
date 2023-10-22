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

  def create#写真投稿の動作の記述
    @photo = Photo.new(photo_params)
    @photo.customer_id = current_customer.id
    if @photo.save
    flash[:notice] = "写真の投稿に成功しました！"#動作ok!写真投稿できたら表示する記述
      redirect_to customer_photo_path(@photo.id)
    else
      @customer = current_customer
      flash[:alert] = "写真の投稿に失敗しました。"  # 動作ok!写真投稿失敗した記述
      @photos = @customer.photos.page(params[:page]) # 1ページに12個の写真を表示
                          .per(12)
      render 'customer/customers/mypage'


    end
  end

  def edit
  @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    #if @photo.customer_id == current_customer.id
      if @photo.update(photo_params)
      flash[:notice] = "編集の更新に成功しました！"#写真の編集に成功したら表示する記述
      redirect_to customer_photo_path(@photo.id)
      else
      #render :editredirect_to customer_photo_path(@photo.id)
      #render :edit
      flash[:alert] = "編集の更新に失敗しました。"
      render 'customer/photos/edit' # 編集ページにリダイレクトし、エラーメッセージを表
    end
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

