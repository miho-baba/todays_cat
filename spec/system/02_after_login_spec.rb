require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let!(:customer) { create(:customer) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
    sleep 1  # Add a small delay to ensure the page has loaded
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'マイページを押すと、自分のマイページ画面に遷移する' do
        all_links = all('a', text: 'マイページ')
        # all_linksが空でないことを確認
        expect(all_links).not_to be_empty
        # 最初のリンクを取得
        mypage_link = all_links.first
        # 他のアクションを追加
        expect(mypage_link['href']).to eq mypage_customer_customers_path
        mypage_link.click
        is_expected.to eq '/customer/customers/mypage'
      end

      it '猫写真を押すと、投稿一覧画面に遷移する' do
        photos_link = first('a', text: '猫写真', visible: false)
        photos_link.click
        is_expected.to eq '/customer/photos'
      end

      it '今日猫会員を押すと、会員一覧画面に遷移する' do
        customers_link = first('a', text: '今日猫会員', visible: false)
        customers_link.click
        is_expected.to eq '/customer/customers'
      end
    end
  end
end
