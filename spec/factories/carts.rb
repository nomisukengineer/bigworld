FactoryBot.define do
  factory :cart do
#    references { "" }
#    references { "" }
    cart_count { 1 }
    user
    ware
  end
end
