class Customer::ChatsController < ApplicationController
  # showアクションにおいて、関連のない会員をブロックする
  before_action :block_non_related_customers, only: [:show]

  # チャットルームの表示
  def show
    # チャット相手の会員を取得
    @customer = Customer.find(params[:id])
    # 現在の会員が参加しているチャットルームの一覧を取得
    rooms = current_customer.customer_rooms.pluck(:room_id)
    # 相手(会員)との共有チャットルームが存在するか確認
    customer_rooms = CustomerRoom.find_by(customer_id: @customer.id, room_id: rooms)
    unless customer_rooms.nil?
      # 共有チャットルームが存在する場合、そのチャットルームを表示
      @room = customer_rooms.room
    else
      # 共有チャットルームが存在しない場合、新しいチャットルームを作成
      @room = Room.new
      @room.save
      # チャットルームに現在の会員と相手会員を追加
      CustomerRoom.create(customer_id: current_customer.id, room_id: @room.id)
      CustomerRoom.create(customer_id: @customer.id, room_id: @room.id)
    end
    # チャットルームに関連付けられたメッセージを取得
    @chats = @room.chats
    # 新しいメッセージを作成するための空のChatオブジェクトを生成
    @chat = Chat.new(room_id: @room.id)
  end

  # チャットメッセージの送信
  def create
    # フォームから送信されたメッセージを取得し、現在のユーザーに関連付けて保存
    @chat = current_customer.chats.new(chat_params)
    # 画像が存在する場合のみ添付する
    @chat.save
  end

  # チャットメッセージの削除
  def destroy
    @chat = current_customer.chats.find(params[:id])
    if @chat.image.attached?
      @chat.purge_image
    end
    # 相手のルームと会員IDを探しにいく記述
    customer_id = CustomerRoom.where(room_id: @chat.room_id).where.not(customer_id: current_customer.id).limit(1)[0].customer_id
    if @chat.destroy
      respond_to do |format|
        # 会員IDを探しにいき、削除する
        format.html { redirect_to customer_chat_path(customer_id), notice: 'チャットメッセージが削除されました' }
        format.js
      end
    end
  end

  private
  # DMの画像の記述
  def chat_params
    params.require(:chat).permit(:message, :room_id, :image)
  end

  # 関連のない会員をブロックする
  def block_non_related_customers
    # チャット相手の会員を取得
    customer = Customer.find(params[:id])
    # 会員がお互いにフォローしているか確認し、していない場合はリダイレクト
    unless current_customer.following?(customer) && customer.following?(current_customer)
      redirect_to photos_path # リダイレクト先は適切なものに変更
    end
  end
end
