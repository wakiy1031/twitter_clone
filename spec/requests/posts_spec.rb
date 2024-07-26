# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'ポスト' do
    let(:user) { create(:user) }

    context 'パラメータが正常な場合' do
      before do
        user.confirm
        sign_in user
      end

      it 'リクエストが成功すること' do
        post_params = { post: { content: 'テスト投稿です' } }
        post posts_path, params: post_params, headers: { 'HTTP_REFERER' => posts_path }
        expect(response).to have_http_status(:found)
      end

      it 'ツイートが作成されること' do
        post_params = { post: { content: 'テスト投稿です' } }
        expect do
          post posts_path, params: post_params, headers: { 'HTTP_REFERER' => posts_path }
        end.to change(user.posts, :count).by 1
      end

      it '投稿一覧ページにリダイレクトされること' do
        post_params = { post: { content: 'テスト投稿です' } }
        post posts_path, params: post_params, headers: { 'HTTP_REFERER' => posts_path }
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'パラメータが不正な場合' do
      before do
        user.confirm
        sign_in user
      end

      it 'リクエストが成功すること' do
        post_params = { post: { content: '' } }
        post posts_path, params: post_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ツイートが作成されないこと' do
        post_params = { post: { content: '' } }
        expect do
          post posts_path, params: post_params
        end.not_to change(user.posts, :count)
        expect(flash[:alert]).to eq('140字以内の投稿にしてください。')
      end
    end
  end
end
