require "#{Rails.root}/app/models/cart"

class Tasks::SampleBatch
    def self.execute
        #test = Test.new
        @cart_ids = Cart.where("updated_at <= CURRENT_TIMESTAMP - INTERVAL 24 hour").ids
        @cart_ids.each do |cart_id|
            Cart.find(cart_id).destroy
        end
    end
end