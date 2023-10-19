class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise で使用する機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #１：Nの関連の記述
  has_many :photos, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  has_one_attached :profile_image

  #新規登録のバリデーション
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
  #会員紹介文のバリデーション
  validates :introduction,length: { maximum: 50 }

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
     profile_image.variant(resize_to_limit: [width, height]).processed
  end

  #検索条件の記述
  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where('last_name': content).or(Customer.where("first_name": content))
    elsif method == 'forward'
      Customer.where('last_name LIKE ?', content + '%').or(Customer.where("first_name LIKE ?", content + '%'))
    elsif method == 'backward'
      Customer.where('last_name LIKE ?', '%' + content).or(Customer.where("first_name LIKE ?", '%' + content))
    else
      Customer.where('last_name LIKE ?', '%' + content + '%').or(Customer.where('last_name LIKE ?', '%' + content + '%'))
    end
  end
end
