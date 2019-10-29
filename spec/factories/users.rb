FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    birthday { "2019-10-29" }
    creditcard { "MyString" }
    creditpass { "MyString" }
    remember_digest { "MyString" }
    activation_digest { "MyString" }
    activated { false }
    activated_at { "2019-10-29 00:37:09" }
    reset_digest { "MyString" }
    reset_sent_at { "2019-10-29 00:37:09" }
  end
end
