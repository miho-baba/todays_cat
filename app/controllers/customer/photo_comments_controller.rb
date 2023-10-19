class Customer::PhotoCommentsController < ApplicationController

  #新しいコメントを作成する記述
  def create
    photo = Photo.find(params[:photo_id])
    comment = current_customer.photo_comments.new(photo_comment_params)
    comment.photo_id = photo.id
    comment.save
    redirect_to request.referer
  end

  #コメントを削除する記述
  def destroy
    comment = PhotoComment.find(params[:id])
    @photo = comment.photo
    comment.destroy
    redirect_to request.referer
  end

  private

  #コメント作成時に必要なcommentパラメータのみを許可する記述
  def photo_comment_params
    params.require(:photo_comment).permit(:comment)
  end

end
