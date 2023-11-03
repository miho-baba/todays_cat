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
    @customers = customer.followings
    #@followings = @customer.followings # 顧客がフォローしているユーザーを取得
  end

  #フォロワー：特定のユーザーをフォローしているユーザーの一覧を表示する記述
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end

end
