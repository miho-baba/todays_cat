class Customer::RelationshipsController < ApplicationController
 before_action :authenticate_customer!

  #ユーザーをフォローする記述
  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  #ユーザーのフォローを解除する記述
  def destroy
    customer = Customer.find(params[:customer_id])
    current_customer.unfollow(customer)
    redirect_to  request.referer
  end

  #特定のユーザーがフォローしているユーザーの一覧を表示する記述
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.page(params[:page]).per(6)# 1ページに6個の写真を表示
  end

  #フォロワー：特定のユーザーをフォローしているユーザーの一覧を表示する記述
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.page(params[:page]).per(6)# 1ページに6個の写真を表示
  end

end
