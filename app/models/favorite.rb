class Favorite < ApplicationRecord
  #１：Nの関連の
  belongs_to :customer
  belongs_to :photo

  #複数回お気に入りに登録できないように制約するを設定の記述
  validates_uniqueness_of :book_id, scope: :user_id

end
