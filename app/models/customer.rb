class Customer < ApplicationRecord
  # devise で使用する機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # １：Nの関連の記述
  has_many :photos, dependent: :destroy
  has_many :favorites
  has_many :favorites, dependent: :destroy
  has_many :photo_comments, dependent: :destroy
  # フォローしている関連付け
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :customer_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :customer_rooms
  # プロフィール画像の記述
  has_one_attached :profile_image

  # 新規登録のバリデーション
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true

  # 会員紹介文のバリデーション
  validates :introduction, length: { maximum: 50 } # 最大50文字(50文字以下)

  # 画像設定の記述
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # 指定したユーザーをフォローする
  def follow(customer_id)
    active_relationships.create(followed_id: customer_id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(customer_id)
    active_relationships.find_by(followed_id: customer_id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(customer)
    followings.include?(customer)
  end

  # 会員検索条件の記述
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

  # 管理者検索条件の記述
  def self.admin_search_for(content, method)
    if method == 'perfect'
      Customer.where('last_name': content).or(Customer.where("first_name": content)).or(Customer.where(id: content))
    elsif method == 'forward'
      Customer.where('last_name LIKE ?', content + '%').or(Customer.where("first_name LIKE ?", content + '%')) or (Customer.where("id LIKE ?", content + '%'))
    elsif method == 'backward'
      Customer.where('last_name LIKE ?', '%' + content).or(Customer.where("first_name LIKE ?", '%' + content)).or(Customer.where("id LIKE ?", '%' + content))
    else
      Customer.where('last_name LIKE ?', '%' + content + '%').or(Customer.where('first_name LIKE ?', '%' + content + '%')).or(Customer.where('id LIKE ?', '%' + content + '%'))
    end
  end

  # is_deletedがfalseならtrueを返すようにしている
  def withdraw
    update(is_deleted: true)
  end
end
