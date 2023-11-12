require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit user_root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(user_root_path).to eq '/user'
      end
     end
    end
   end

