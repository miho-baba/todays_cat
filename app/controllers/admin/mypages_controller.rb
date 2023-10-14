class Admin::MypagesController < ApplicationController

#before_action :set_admin, only: [:show]
  def show
    @admin = current_admin
  end

  private

  def admin_params
    params.require(:admin).permit(:email, :password)
  end


  #def set_admin
    #@admin = Admin.find([:id])
  #end
end
