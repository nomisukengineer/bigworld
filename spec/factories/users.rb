FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "nominomi@gmail.com" }
    password { "nominomi1" }
    password_confirmation { "nominomi1" }
    birthday { "2019-10-29" }
    creditcard { 123455678 }
    creditpass { 123 }
    postcode {1234567}
    address {"東京都"}
    remember_digest { nil }
    activation_digest { "MyString" }
    activated { false }
    activated_at { "2019-10-29 00:37:09" }
    reset_digest { "MyString" }
    reset_sent_at { "2019-10-29 00:37:09" }
  end
end
