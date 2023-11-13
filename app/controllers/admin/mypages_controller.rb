class Admin::MypagesController < ApplicationController
  def show
    @admin = current_admin
  end

  private
    def admin_params
      params.require(:admin).permit(:email, :password)
    end
end
