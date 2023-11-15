# ./spec/system/01_before_login_spec.rb
require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end

      it 'Log inリンクが表示される: 薄緑のボタンの表示が「ログイン」である' do
        log_in_link = find_all('a')[2].text
        expect(log_in_link).to match(/ログイン/)
      end

      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[2]
        expect(log_in_link['href']).to eq new_customer_session_path  # href属性を直接比較
      end

      it 'Sign upリンクが表示される: 薄緑のボタンの表示が「新規登録」である' do
        sign_up_link = find_all('a')[3].text
        expect(sign_up_link).to match(/新規登録/)
      end

      it 'Sign upリンクの内容が正しい' do
        sign_up_link = find_all('a')[3]
        expect(sign_up_link['href']).to eq new_customer_registration_path  # href属性を直接比較
      end
    end
  end
end
