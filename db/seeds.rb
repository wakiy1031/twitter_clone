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
    introduction: "自己紹介文が入ります",
    place: "日本 東京",
    website: "example.com"
  )
  user.birthdate = '2024-07-03'
  user.password = 'password'
  user.password_confirmation = 'password'
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

Rails.logger.debug 'ユーザーと投稿の確認:'
User.all.each do |user|
  Rails.logger.debug "ユーザー: #{user.user_name}"
  user.posts.each do |post|
    Rails.logger.debug "  - #{post.content}"
  end
  Rails.logger.debug "\n"
end

Rails.logger.debug 'フォロー関係の確認:'
Rails.logger.debug "#{first_user.user_name}がフォローしているユーザー:"
first_user.followees.each do |followed_user|
  Rails.logger.debug "  - #{followed_user.user_name}"
end
