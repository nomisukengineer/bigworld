# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             birthday: "1996-12-15",
             postcode: "1040061",
             address: "東京都中央区銀座６丁目10",
             creditcard: "123456789",
             creditpass: "123"
             )

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  password_confirmation = "password"
  birthday = Faker::Time.between(40.years.ago, 18.years.ago, :all).to_s[0, 10]
  postcode = "1234567"
  address = Faker::Address.full_address
  creditcard = "123456789"
  creditpass = "456"
  User.create!(name:  name,
               email: email,
               password:   password,
               password_confirmation: password_confirmation,
               birthday: birthday,
               postcode: postcode,
               address: address,
               creditcard: creditcard,
               creditpass: creditpass
               )
end



Gender.create!(gender_name:  "Men")
Gender.create!(gender_name:  "Wemen")


Category.create!(category_name:  "コート")
Category.create!(category_name:  "ジャンパー")
Category.create!(category_name:  "パーカー")
Category.create!(category_name:  "シャツ")
Category.create!(category_name:  "Tシャツ")
Category.create!(category_name:  "半ズボン")
Category.create!(category_name:  "長ズボン")
Category.create!(category_name:  "スカート")
Category.create!(category_name:  "ワンピース")


Product.create!(product_name:  "例えばTシャツ",
                gender_id: "1",
                category_id: "5",
                price: "1100",
                picture: "1.png"
            )

99.times do |n|
    product_name  = Faker::Name.name
    gender_id = Faker::Number.between(from =1, to = 2)
    @category_id = Faker::Number.between(from =1, to = 8)
    price = Faker::Commerce.price(range = 1000..10000.0, as_string = false)
#    @picture = Faker::Number.between(from =1, to = 10)
    Product.create!(product_name:  product_name,
        gender_id: gender_id,
        category_id:   @category_id,
        price: price,
        picture: @category_id
        )
end


Size.create!(size_name:  "XL")
Size.create!(size_name:  "2XL")
Size.create!(size_name:  "3XL")
Size.create!(size_name:  "4XL")
Size.create!(size_name:  "5XL")



Ware.create!(product_id:  "1",
            size_id: "1",
            amount:   10
            )


Ware.create!(product_id:  1,
        size_id: 2,
        amount: 10
        )



Cart.create!(user_id: "1",
            ware_id: "1",
            cart_count: "2"
            )

Order.create!(user_id: "1",
            ware_id: "1",
            order_count: "1"
            )


Cart.create!(user_id: "1",
            ware_id: "2",
            cart_count: "1"
            )

Reaction.create!(reaction_name: "お気に入り"
            )

Favorite.create!(user_id: "1",
                reaction_id: "1",
                product_id: "1"
            )

Favorite.create!(user_id: "1",
                reaction_id: "1",
                product_id: "2"
            )

Favorite.create!(user_id: "2",
            reaction_id: "1",
            product_id: "5"
            )


User.create!(name:  "Example User1",
             email: "example1@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             birthday: "1996-12-15",
             postcode: "1040061",
             address: "東京都中央区銀座６丁目10",
             creditcard: "123456789",
             creditpass: "123",
             admin:true
             )