# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

=begin
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password_digest:              "foobar",
             birthday: "1996-12-15",
             creditcard: "123456789",
             creditpass: "123"
             )

999999.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password_digest = "password"
  birthday = Faker::Time.between(40.years.ago, 18.years.ago, :all).to_s[0, 10]
  creditcard = Faker::Business.credit_card_number
  creditpass = "456"
  User.create!(name:  name,
               email: email,
               password_digest:   password_digest,
               birthday: birthday,
               creditcard: creditcard,
               creditpass: creditpass
               )
end
=end

Product.create!(product_name:  "例えばTシャツ",
                gender_id: "1",
                category_id: "5",
                price: "1100",
                picture: "User/naohiro-nomi/picture/image.jpg"
            )

999999.times do |n|
    product_name  = Faker::Name.name
    gender_id = Faker::Number.between(from =1, to = 2)
    category_id = Faker::Number.between(from =1, to = 10)
    price = Faker::Commerce.price(range = 1000..10000.0, as_string = false)
    picture = Faker::Internet.url
    Product.create!(product_name:  product_name,
        gender_id: gender_id,
        category_id:   category_id,
        price: price,
        picture: picture,
        )
end
