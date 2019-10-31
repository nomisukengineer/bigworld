module ProductsHelper
=begin
    # 引数で与えられたユーザーのGravatar画像を返す
    def gravatar_for(product)
        gravatar_id = Digest::MD5::hexdigest(product.id)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: product.product_name, class: "gravatar")
    end
=end
end
