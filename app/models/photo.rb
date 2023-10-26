class Photo < ApplicationRecord
   #１：Nの関連の記述
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :photo_comments, dependent: :destroy
  has_one_attached :image
  #写真のバリデーションの記述を書く
  validates :title, presence: true, length: { in: 1..20 }# 1文字以上20文字以下
  validates :photo_introduction, presence: true, length: { maximum: 200 }# 最大200文字(200文字以下)
  validates :cat_color, presence: true, length: { in: 1..20 }# 1文字以上20文字以下

  #いいねしているか判定する
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  #画像の記述
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  #猫の特徴&タイトル：検索条件の記述
  def self.search_for(content, method)
    if method == 'perfect'
      Photo.where('title': content).or(Photo.where("cat_color": content))
    elsif method == 'forward'
      Photo.where('title LIKE ?', content + '%').or(Photo.where("cat_color LIKE ?", content + '%'))
    elsif method == 'backward'
      Photo.where('title LIKE ?', '%' + content).or(Photo.where("cat_color LIKE ?", '%' + content))
    else
      Photo.where('title LIKE ?', '%' + content + '%').or(Photo.where("cat_color LIKE ?", '%' + content + '%'))
    end
  end

end
