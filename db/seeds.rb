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

odd_users = users.values_at(2, 4, 6, 8, 10)
even_users = users.values_at(1, 3, 5, 7, 9)

odd_users.each do |user|
  even_users.each do |target|
    # フォロー
    user.follow(target.id)

    # いいね、リポスト、コメント
    target.posts.each do |post|
      user.like(post)
      user.repost(post)
      user.comments.create(post: post, content: "#{user.user_name}からのコメントです。")
    end
  end
end

even_users.each do |user|
  odd_users.each do |target|
    # フォロー
    user.follow(target.id)

    # いいね、リポスト、コメント
    target.posts.each do |post|
      user.like(post)
      user.repost(post)
      user.comments.create(post: post, content: "#{user.user_name}からのコメントです。")
    end
  end
end

# 動作確認
puts "ユーザーと投稿の確認:"
User.all.each do |user|
  puts "ユーザー: #{user.user_name}"
  user.posts.each do |post|
    puts "  - 投稿: #{post.content}"
    puts "    - いいね数: #{post.likes.count}"
    puts "    - リポスト数: #{post.reposts.count}"
    puts "    - コメント数: #{post.comments.count}"
  end
  puts "\n"
end

puts "フォロー関係の確認:"
User.all.each do |user|
  puts "#{user.user_name}がフォローしているユーザー:"
  user.followees.each do |followed_user|
    puts "  - #{followed_user.user_name}"
  end
  puts "\n"
end

puts "いいね、リポスト、コメントの詳細:"
Post.all.each do |post|
  puts "投稿: #{post.content} (by #{post.user.user_name})"
  puts "  いいねしたユーザー:"
  post.likes.each do |like|
    puts "    - #{like.user.user_name}"
  end
  puts "  リポストしたユーザー:"
  post.reposts.each do |repost|
    puts "    - #{repost.user.user_name}"
  end
  puts "  コメント:"
  post.comments.each do |comment|
    puts "    - #{comment.user.user_name}: #{comment.content}"
  end
  puts "\n"
end
