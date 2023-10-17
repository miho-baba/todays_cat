class Favorite < ApplicationRecord
  #１：Nの関連の
  belongs_to :customer
  belongs_to :photo

end
