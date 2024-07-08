# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :posts, dependent: :destroy
  has_one_attached :avatar_image
  has_one_attached :header_image

  # フォローする
  has_many :active_follows,
           class_name: 'Follow',
           foreign_key: 'follower_id',
           dependent: :destroy,
           inverse_of: :follower

  # フォローされている
  has_many :passive_follows,
           class_name: 'Follow',
           foreign_key: 'followee_id',
           dependent: :destroy,
           inverse_of: :followee

  # フォローしているユーザーの情報
  has_many :followees, through: :active_follows, source: :followee

  # 　フォローされているユーザーの情報
  has_many :followers, through: :passive_follows, source: :follower

  has_many :likes, dependent: :destroy
  has_many :reposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :like_posts, through: :likes, source: :post
  has_many :repost_posts, through: :reposts, source: :post
  has_many :comment_posts, through: :comments, source: :post

  validates :phone, presence: true, unless: :provider_github?
  validates :birthdate, presence: true, unless: :provider_github?
  validates :user_name, presence: true, uniqueness: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.user_name = auth.info.nickname
      user.skip_confirmation!
    end
  end

  # フォローする
  def follow(user_id)
    active_follows.create(followee_id: user_id)
  end

  # フォローを外す
  def unfollow(user_id)
    active_follows.find_by(followee_id: user_id).destroy
  end

  # すでにフォローしているのか確認
  def following?(user)
    followees.include?(user)
  end

  def repost(post)
    reposts.create(post_id: post.id)
  end

  def like(post)
    likes.create(post_id: post.id)
  end

  private

  def provider_github?
    provider == 'github'
  end
end
