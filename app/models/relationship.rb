class Relationship < ApplicationRecord

  #リレーションの設定の記述
  belongs_to :follower, class_name: "Customer"
  belongs_to :followed, class_name: "Customer"

end
