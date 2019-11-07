class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :reaction
  belongs_to :product
end
