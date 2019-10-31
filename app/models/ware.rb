class Ware < ApplicationRecord
    belongs_to :product
    belongs_to :size
    has_many :carts
end

