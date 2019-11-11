class Cart < ApplicationRecord
    belongs_to :ware, optional: true
    belongs_to :user, optional: true

=begin
    def self.get_ware_ids(product_id)
        Product.find(product_id).wares.pluck("size_id").uniq
    end
=end
end
