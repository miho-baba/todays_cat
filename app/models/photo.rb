class Photo < ApplicationRecord
   #１：Nの関連の記述
  belongs_to :customer
  has_many :favorite, dependent: :destroy
  has_one_attached :image
  #写真のバリデーションの記述を書く
  validates :title, presence: true
  validates :photo_introduction, length: { maximum: 200 }, presence: true

  #いいねしているか判定する
  def favorited_by?(cutomer)
    favorites.exists?(cutomer_id: cutomer.id)
  end



  #画像の記述
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end


end
