class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    # 選択したモデルに応じて検索を実行
    if @model == "customer"
        @customers = Customer.admin_search_for(@content, @method).page(params[:page]).per(5)# 1ページに5個の写真を表示
    end
  end








end
