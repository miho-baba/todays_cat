class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #devise で使用する機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
