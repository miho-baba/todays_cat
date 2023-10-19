class PhotoComment < ApplicationRecord

  #１：Nの関連づけ
  belongs_to :customer
  belongs_to :photo

  #空のコメントが保存されない記述のバリデーション
  validates :comment, presence: true

end
