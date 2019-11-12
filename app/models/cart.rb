class Cart < ApplicationRecord
    belongs_to :ware
    belongs_to :user

=begin
    def self.get_ware_ids(product_id)
        Product.find(product_id).wares.pluck("size_id").uniq
    end
=end
end
