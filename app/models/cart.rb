class Cart < ApplicationRecord
    belongs_to :ware
    belongs_to :user
end
