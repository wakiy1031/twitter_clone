# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'ポスト' do
    let(:user) { create(:user) }

    context 'パラメータが正常な場合' do
      before do
        user.confirm
        sign_in user
      end

      it '投稿' do
        content = 'テスト投稿'

        expect do
          visit root_path
          fill_in 'post[content]', with: content
          click_button 'Post'
        end.to change(user.posts, :count).by 1

        expect(page).to have_content content
      end
    end

    context 'パラメータが不正な場合' do
      before do
        user.confirm
        sign_in user
      end

      it '投稿内容なしの投稿' do
        expect do
          visit root_path
          fill_in 'post[content]', with: ''
          click_button 'Post'
        end.not_to change(user.posts, :count)

        expect(page).to have_content '140字以内の投稿にしてください。'
      end
    end
  end
end
