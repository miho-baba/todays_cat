require 'rails_helper'

describe '[STEP3] 仕上げのテスト' do
  let!(:customer) { create(:customer) }
  let!(:other_customer) { create(:customer) }
  let!(:photo) { create(:photo, customer: customer) }
  let!(:other_photo) { create(:photo, customer: other_customer) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it '会員新規登録成功時' do
      visit new_customer_registration_path
      fill_in 'customer[first_name]', with: customer.first_name
      fill_in 'customer[last_name]', with: customer.last_name
      fill_in 'customer[first_name_kana]', with: customer.first_name_kana
      fill_in 'customer[last_name_kana]', with: customer.last_name_kana
      fill_in 'customer[phone_number]', with: customer.phone_number
      fill_in 'customer[password]', with: customer.password
      click_button '登録'
    end

    it '会員ログイン成功時' do
      visit new_customer_session_path
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    it '会員ログアウト成功時' do
      destroy_customer_session_path
    end

    it '会員のプロフィール情報更新成功時' do
      customer_customer_path(customer)
    end

    it '投稿データの新規投稿成功時: マイページ画面から行う' do
      create(:photo, customer: customer)
      sign_in customer # ユーザーをログインさせる
      visit mypage_customer_customers_path
      click_button '投稿する'
    end
  end
end
