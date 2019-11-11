FactoryBot.define do
  factory :cart do
#    references { "" }
#    references { "" }
    carts_count { 5 }
    user
    ware
  end
end
