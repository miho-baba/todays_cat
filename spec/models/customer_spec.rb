require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
    end
    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
    end
    context 'first_name_kanaカラム' do
      it '空欄でないこと' do
        customer.first_name_kana = ''
        is_expected.to eq false
      end
    end
    context 'last_name_kanaカラム' do
      it '空欄でないこと' do
        customer.last_name_kana = ''
        is_expected.to eq false
      end
    end
    context 'phone_numberカラム' do
      it '空欄でないこと' do
        customer.phone_number = ''
        is_expected.to eq false
      end
    end
    context 'introductionカラム' do
      it '50文字以下であること: 50文字は〇' do
        customer.introduction = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字は×' do
        customer.introduction = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Photoモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:photos).macro).to eq :has_many
      end
    end
  end
end
