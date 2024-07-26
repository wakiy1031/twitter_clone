# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test-#{n}@exmaple.com" }
    phone { '09012345678' }
    birthdate { '2024-07-03' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
