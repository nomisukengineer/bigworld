class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :reaction
  belongs_to :product
  validates :product_id, uniqueness: true
end
