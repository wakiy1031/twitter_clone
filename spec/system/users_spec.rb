# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'サインアップ' do
    context 'パラメータが正常な場合' do
      let(:user) { build(:user) }

      it 'アカウントを作成' do
        expect do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: user.user_name
          fill_in 'メール', with: user.email
          fill_in '電話番号', with: user.phone
          select user.birthdate.year.to_s, from: 'user_birthdate_1i'
          select user.birthdate.month.to_s, from: 'user_birthdate_2i'
          select user.birthdate.day.to_s, from: 'user_birthdate_3i'
          fill_in 'パスワード', with: user.password
          fill_in 'パスワード（確認用）', with: user.password
          click_button '作成する'
        end.to change { ActionMailer::Base.deliveries.count }.by(1)

        expect(page).to have_content 'ログインもしくはアカウント登録してください。'
      end
    end

    context 'パラメータが不正な場合' do
      let(:user) { build(:user) }

      it 'メールアドレスが未入力の場合' do
        expect do
          visit new_user_registration_path
          fill_in 'ユーザー名', with: user.user_name
          fill_in 'メール', with: ''
          fill_in '電話番号', with: user.phone
          select user.birthdate.year.to_s, from: 'user_birthdate_1i'
          select user.birthdate.month.to_s, from: 'user_birthdate_2i'
          select user.birthdate.day.to_s, from: 'user_birthdate_3i'
          fill_in 'パスワード', with: user.password
          fill_in 'パスワード（確認用）', with: user.password
          click_button '作成する'
        end.to change(User, :count).by 0

        expect(page).to have_content 'メールを入力してください'
      end
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    before do
      user.confirm
    end

    context 'パラメータが正常な場合' do
      it 'ログイン' do
        visit new_user_session_path
        fill_in 'メール', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログインする'

        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'パラメータが不正な場合' do
      it 'パスワード入力なしでログイン' do
        visit new_user_session_path
        fill_in 'メール', with: user.email
        fill_in 'パスワード', with: ''
        click_button 'ログインする'

        expect(page).to have_content 'メールまたはパスワードが違います。'
      end
    end
  end
end
