class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  # DM送信の際、画像を取り扱うための記述
  has_one_attached :image
  # メッセージが空でなく、140字以下であることを検証するバリデーション
  validates :message, presence: true, length: { maximum: 140 }
  # 画像を削除するメソッド
  def purge_image
    image.purge
  end
end
