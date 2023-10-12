class Customer::MypagesController < ApplicationController

# before_action :set_customer, only: [:show]

  def show
    @customer = current_customer
  end

  # 必要ならコメントアウトをはずすprivate

  # def set_customer
  #   @customer = Customer.find([:id])
  # end
end
