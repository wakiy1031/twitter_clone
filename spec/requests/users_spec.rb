# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'サインアップ' do
    let(:user) { create(:user) }

    context 'パラメータが正常な場合' do
      let(:valid_params) { { user: attributes_for(:user) } }

      it 'リクエスト（302 リダイレクト）が成功すること' do
        post user_registration_path, params: valid_params
        expect(response).to have_http_status(:see_other)
      end

      it 'ユーザーが作成されること' do
        expect {
          post user_registration_path, params: valid_params
        }.to change(User, :count).by(1)
      end

      it '認証メールが送信されること' do
        expect {
          post user_registration_path, params: valid_params
        }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it '登録のメッセージが設定されること' do
        post user_registration_path, params: valid_params
        expect(flash[:notice]).to eq('本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。')
      end

      it '投稿一覧ページにリダイレクトされること' do
        post user_registration_path, params: valid_params
        expect(response).to redirect_to(root_path)
      end

    end

    context 'パラメータが不正な場合' do
      let(:invalid_params) { { user: attributes_for(:user, email: '') } }

      it 'リクエストが成功すること' do
        post user_registration_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ユーザーが作成されないこと' do
        expect {
          post user_registration_path, params: invalid_params
        }.not_to change(User, :count)
      end
    end
  end
end
