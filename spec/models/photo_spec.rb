require 'rails_helper'

RSpec.describe 'Photoモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { photo.valid? }

    let(:customer) { create(:customer) }
    let!(:photo) { build(:photo, customer_id: customer.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        photo.title = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        photo.title = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        photo.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'photo_introductionカラム' do
      it '空欄でないこと' do
        photo.photo_introduction = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        photo.photo_introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        photo.photo_introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'cat_colorカラム' do
      it '空欄でないこと' do
        photo.cat_color = ''
        is_expected.to eq false
      end
      it '20文字以下であること: 20文字は〇' do
        photo.cat_color = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        photo.cat_color = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Photo.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
  end
end
