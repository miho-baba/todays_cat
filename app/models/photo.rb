class Photo < ApplicationRecord
  #アソシエーションの記述
  belongs_to :customer
  has_one_attached :image
  #後ほど、写真のバリデーションの記述を書く

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end


end
