class Product < ApplicationRecord
    belongs_to :gender
    belongs_to :category
    has_many :wares
    has_many :favorites
    validates :product_name, presence: true, length: { maximum: 30 }

    def self.get_size_ids(product_id)
        Product.find(product_id).wares.pluck("size_id").uniq
    end

#    def self.get_gender_ids(product_id)
#        Product.find(product_id).wares.pluck("gender_id").uniq
#    end



    def self.search(search) #ここでのself.はUser.を意味する
        if search
            where(['product_name LIKE ?', "%#{search}%"]) #検索とnameの部分一致を表示。User.は省略
        else
            all #全て表示。User.は省略
        end
    end

end
