# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: %i[github]

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

  private

  def provider_github?
    provider == 'github'
  end
end
