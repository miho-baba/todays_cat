class Customer::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    current_customer.follow(params[:customer_id])
    redirect_to request.referer
  end

  def destroy
    customer = Customer.find(params[:customer_id])
    current_customer.unfollow(customer)
    redirect_to request.referer
  end

  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings.page(params[:page]).per(6)
  end

  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers.page(params[:page]).per(6)
  end
end