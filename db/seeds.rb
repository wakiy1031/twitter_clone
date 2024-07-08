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
    introduction: '自己紹介文が入ります',
    place: '日本 東京',
    website: 'example.com'
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

odd_users = users.values_at(1, 3, 5, 7, 9)
even_users = users.values_at(0, 2, 4, 6, 8)

odd_users.each do |user|
  even_users.each do |target|
    # フォロー
    user.follow(target.id)

    # いいね、リポスト、コメント
    target.posts.each do |post|
      user.like(post)
      user.repost(post)
      user.comments.create(post:, content: "#{user.user_name}からのコメントです。")
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
      user.comments.create(post:, content: "#{user.user_name}からのコメントです。")
    end
  end
end

# 動作確認
Rails.logger.debug 'ユーザーと投稿の確認:'
User.all.each do |user|
  Rails.logger.debug "ユーザー: #{user.user_name}"
  user.posts.each do |post|
    Rails.logger.debug "  - 投稿: #{post.content}"
    Rails.logger.debug "    - いいね数: #{post.likes.count}"
    Rails.logger.debug "    - リポスト数: #{post.reposts.count}"
    Rails.logger.debug "    - コメント数: #{post.comments.count}"
  end
  Rails.logger.debug "\n"
end

Rails.logger.debug 'フォロー関係の確認:'
User.all.each do |user|
  Rails.logger.debug "#{user.user_name}がフォローしているユーザー:"
  user.followees.each do |followed_user|
    Rails.logger.debug "  - #{followed_user.user_name}"
  end
  Rails.logger.debug "\n"
end

Rails.logger.debug 'いいね、リポスト、コメントの詳細:'
Post.all.each do |post|
  Rails.logger.debug "投稿: #{post.content} (by #{post.user.user_name})"
  Rails.logger.debug '  いいねしたユーザー:'
  post.likes.each do |like|
    Rails.logger.debug "    - #{like.user.user_name}"
  end
  Rails.logger.debug '  リポストしたユーザー:'
  post.reposts.each do |repost|
    Rails.logger.debug "    - #{repost.user.user_name}"
  end
  Rails.logger.debug '  コメント:'
  post.comments.each do |comment|
    Rails.logger.debug "    - #{comment.user.user_name}: #{comment.content}"
  end
  Rails.logger.debug "\n"
end
