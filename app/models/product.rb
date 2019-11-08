class Product < ApplicationRecord
    belongs_to :gender
    belongs_to :category
    has_many :wares
    has_many :favorites

    def self.get_size_ids(product_id)
        Product.find(product_id).wares.pluck("size_id").uniq
    end

    def self.get_gender_ids(product_id)
        Product.find(product_id).wares.pluck("gender_id").uniq
    end



    def self.search(search) #ここでのself.はUser.を意味する
        if search
            where(['product_name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
        else
            all #全て表示。User.は省略
        end
    end

    def zaiko4
        if Ware.where("product_id = #{@product.id} and size_id =4").first.amount.nil?
            0
        else
            Ware.where("product_id = #{@product.id} and size_id =4").first.amount
        end
    end

#    def feed
#        wares.size_ids = "select from wares where product_id = (select products.id from where products.id = 1)"
#        Size.where("sizes.id in (#{ware.size_ids})")
#    end
end
