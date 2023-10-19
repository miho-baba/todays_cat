class Customer::SearchesController < ApplicationController
  before_action :authenticate_customer!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]


    # 選択したモデルに応じて検索を実行
    if @model  == "customer"
      @records = Customer.search_for(@content, @method)
    elsif @model == "photo"
      @records = Photo.search_for(@content, @method)
    end
  end









end
