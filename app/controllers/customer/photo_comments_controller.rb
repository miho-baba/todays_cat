class Customer::PhotoCommentsController < ApplicationController

  #新しいコメントを作成する記述
  def create#非同期通信化
    @photo = Photo.find(params[:photo_id])
    comment = current_customer.photo_comments.new(photo_comment_params)
    comment.photo_id = @photo.id
    comment.save
  end

  #コメントを削除する記述
  def destroy#非同期通信化
    comment = PhotoComment.find(params[:id])
    @photo = comment.photo
    comment.destroy
  end

  private

  #コメント作成時に必要なcommentパラメータのみを許可する記述
  def photo_comment_params
    params.require(:photo_comment).permit(:comment)
  end

end
