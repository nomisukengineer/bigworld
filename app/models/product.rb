class Product < ApplicationRecord
    belongs_to :gender
    belongs_to :category
    has_many :wares


    def feed
        wares.size_ids = "select from wares where product_id = (select products.id from where products.id = 1)"
        Size.where("sizes.id in (#{ware.size_ids})")
    end
end
