# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all

10.times do |u|
  user = User.find_or_initialize_by(
    user_name: "テストユーザー#{u + 1}",
    email: "test-#{u + 1}@example.com",
    phone: "0901111222#{u + 1}",
  )
  user.birthdate = "2024-07-03"
  user.password = "password"
  user.password_confirmation = "password"
  user.skip_confirmation!
  user.save!

  5.times do |t|
    post = user.posts.build(
      content: "テストユーザー#{u + 1}の#{t + 1}個目のツイート"
    )
    post.save!
  end

end

puts "ユーザーと投稿の確認:"
User.all.each do |user|
  puts "ユーザー: #{user.user_name}"
  user.posts.each do |post|
    puts "  - #{post.content}"
  end
  puts "\n"
end
