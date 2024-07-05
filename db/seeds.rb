# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

users = []

10.times do |u|
  user = User.find_or_initialize_by(
    user_name: "test_user#{u + 1}",
    email: "test-#{u + 1}@example.com",
    phone: "0901111222#{u + 1}",
  )
  user.birthdate = "2024-07-03"
  user.password = "password"
  user.password_confirmation = "password"
  user.avatar_image.attach(
    io: File.open(Rails.root.join('app/assets/images/default.webp')),
    filename: 'avatar.jpg'
  )
  user.skip_confirmation!
  user.save!

  users << user

  5.times do |t|
    post = user.posts.build(
      content: "テストユーザー#{u + 1}の#{t + 1}個目のツイート"
    )
    post.save!
  end

end

first_user = users.first
[1, 3, 5, 7].each do |index|
  first_user.follow(users[index].id)
end

puts "ユーザーと投稿の確認:"
User.all.each do |user|
  puts "ユーザー: #{user.user_name}"
  user.posts.each do |post|
    puts "  - #{post.content}"
  end
  puts "\n"
end

puts "フォロー関係の確認:"
puts "#{first_user.user_name}がフォローしているユーザー:"
first_user.followees.each do |followed_user|
  puts "  - #{followed_user.user_name}"
end
