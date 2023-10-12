class Admin::MypagesController < ApplicationController

#before_action :set_admin, only: [:show]
  def show
    @admin = current_admin
  end

  # 必要ならコメントアウトをはずす private

  #def set_admin
    #@admin = Admin.find([:id])
  #end
end
