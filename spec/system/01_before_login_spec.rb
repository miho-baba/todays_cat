# ./spec/system/01_before_login_spec.rb

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path  # user_root_path ではなく root_path を使用
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/user'
      end

      it 'Log inリンクが表示される: 薄緑のボタンの表示が「Log in」である' do
        log_in_link = find_all('a')[5].text
        expect(log_in_link).to match(/Log in/)
      end

      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[5]
        expect(log_in_link['href']).to eq new_customer_session_path  # href属性を直接比較
      end

      it 'Sign upリンクが表示される: 薄緑のボタンの表示が「Sign up」である' do
        sign_up_link = find_all('a')[6].text
        expect(sign_up_link).to match(/Sign up/)
      end

      it 'Sign upリンクの内容が正しい' do
        sign_up_link = find_all('a')[6]
        expect(sign_up_link['href']).to eq new_customer_registration_path  # href属性を直接比較
      end
    end
  end
end