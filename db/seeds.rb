# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

15.times do |n|
  userid = "test#{n+1}"
  name  = "テスト#{n+1}"
  email = "example-#{n+1}@example.com"
  password = "password"
  gender = 1
  prefecture_code = "#{n+1}"
  birthday = "1970-03-#{n+1}"
  User.create!(userid: userid, name:  name,email: email, gender: gender, prefecture_code: prefecture_code,
              password: password, birthday: birthday,
              password_confirmation: password)
end

15.times do |n|
  userid = "test#{n+1}"
  name  = "テスト#{n+15}"
  email = "example-#{n+1}@example.com"
  password = "password"
  gender = 2
  prefecture_code = "#{n+1}"
  birthday = "1990-02-#{n+1}"
  User.create!(userid: userid, name:  name,email: email, gender: gender, prefecture_code: prefecture_code,
              password: password, birthday: birthday,
              password_confirmation: password)
end

users = User.order(:created_at).take(30)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end
