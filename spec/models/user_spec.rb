# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user) { build(:user) }

    context '正常系' do
      it 'すべての属性が正しく設定されている場合、有効であること' do
        expect(user).to be_valid
      end
    end

    context 'ユーザー名(user_name)' do
      it '空の場合、無効であること' do
        user.user_name = ''
        expect(user).to be_invalid
      end
    end

    context 'メールアドレス(email)' do
      it '空の場合、無効であること' do
        user.email = ''
        expect(user).to be_invalid
      end

      it '不正なフォーマットの場合、無効であること' do
        user.email = 'invalid_email'
        expect(user).to be_invalid
      end

      it '一意でない場合、無効であること' do
        create(:user, email: 'test@example.com')
        user.email = 'test@example.com'
        expect(user).to be_invalid
      end
    end

    context '電話番号(phone)' do
      it '空の場合、無効であること' do
        user.phone = ''
        expect(user).to be_invalid
      end
    end

    context '生年月日(birthdate)' do
      it '空の場合、無効であること' do
        user.birthdate = ''
        expect(user).to be_invalid
      end

      it '不正なフォーマットの場合、無効であること' do
        user.birthdate = 'invalid_date'
        expect(user).to be_invalid
      end
    end

    context 'パスワード(password)' do
      it '空の場合、無効であること' do
        user.password = ''
        expect(user).to be_invalid
      end

      it '5文字以下の場合、無効であること' do
        user.password = 'abcde'
        user.password_confirmation = 'abcde'
        expect(user).to be_invalid
      end
    end

    context 'パスワード確認(password_confirmation)' do
      it '空の場合、無効であること' do
        user.password_confirmation = ''
        expect(user).to be_invalid
      end

      it 'パスワードと一致しない場合、無効であること' do
        user.password = 'password'
        user.password_confirmation = 'different'
        expect(user).to be_invalid
      end
    end
  end
end
