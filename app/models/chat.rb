class Chat < ApplicationRecord
  belongs_to :customer
  belongs_to :room

#メッセージが空でなく、140字以下であることを検証するバリデーション
validates :message, presence: true, length: { maximum: 140 }

end
