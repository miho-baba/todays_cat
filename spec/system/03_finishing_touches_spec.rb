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
      fill_in 'customer[password]', with: customer.password
      click_button '登録'
      # 成功メッセージが表示されるまで明示的に待機
      success_message = '新規登録に成功しました！'
      max_wait_time = 10
      wait_time = 0
      interval = 0.5
      until page.has_content?(success_message) || wait_time >= max_wait_time
        sleep interval
        wait_time += interval
      end
      # Debugging information
      if wait_time >= max_wait_time
        puts "Debug: Success message not found. Taking a screenshot for debugging."
        page.save_screenshot('debug_screenshot.png')
        puts "Debug: Screenshot saved as debug_screenshot.png"
      end
      expect(page).to have_content success_message
    end

    xit '会員ログイン成功時' do
      visit new_user_session_path
      fill_in 'customer[first_name]', with: customer.first_name
      fill_in 'customer[last_name]', with: customer.last_name
      fill_in 'customer[first_name_kana]', with: customer.first_name_kana
      fill_in 'customer[last_name_kana]', with: customer.last_name_kana
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      is_expected.to have_content 'ログインしました！'
    end

    xit 'ユーザログアウト成功時' do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[4].text
      logout_link = logout_link.strip
      click_link logout_link
      is_expected.to have_content 'successfully'
    end

    xit 'ユーザのプロフィール情報更新成功時' do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit edit_user_path(user)
      click_button 'Update User'
      is_expected.to have_content 'successfully'
    end

    xit '投稿データの新規投稿成功時: 投稿一覧画面から行います。' do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit books_path
      fill_in 'book[title]', with: Faker::Lorem.characters(number: 5)
      fill_in 'book[body]', with: Faker::Lorem.characters(number: 20)
      click_button 'Create Book'
      is_expected.to have_content 'successfully'
    end

    xit '投稿データの更新成功時' do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit edit_book_path(book)
      click_button 'Update Book'
      is_expected.to have_content 'successfully'
    end
  end
end
