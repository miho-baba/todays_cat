class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #新規登録のバリデーション
  validates :email, presence: true

  #検索条件の記述
  def self.search_for(content, method)
    if method == 'perfect'
      Customer.where('last_name': content).or(Customer.where("first_name": content)).or(Customer.where("customer.id": content))
    elsif method == 'forward'
      Customer.where('last_name LIKE ?', content + '%').or(Customer.where("first_name LIKE ?", content + '%'))or(Customer.where("customer.id LIKE ?", content + '%'))
    elsif method == 'backward'
      Customer.where('last_name LIKE ?', '%' + content).or(Customer.where("first_name LIKE ?", '%' + content)).or(Customer.where("customer.id LIKE ?", '%' + content))
    else
      Customer.where('last_name LIKE ?', '%' + content + '%')..or(Customer.where('first_name LIKE ?', '%' + content + '%'))or(Customer.where('customer.id LIKE ?', '%' + content + '%'))
    end
  end

end
