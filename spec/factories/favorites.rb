FactoryBot.define do
  factory :favorite do
    user { nil }
#    reaction { nil }
    reaction
    product
    user
  end
end
