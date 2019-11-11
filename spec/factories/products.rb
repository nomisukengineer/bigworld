FactoryBot.define do
  factory :product do
    product_name { "MyString" }
    # gender_id { "" }
    # category_id { "" }
    price { "1" }
    picture { "MyString" }
    gender
    category
  end
end
