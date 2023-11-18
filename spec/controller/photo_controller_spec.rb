require "rails_helper"

RSpec.describe Customer::PhotosController, type: :controller do
  let!(:customer) { create(:customer) }
  let(:valid_attributes) {
    { customer_id: 1, title: 'Test Photo', cat_color: 'white', photo_introduction: 'Some introduction' }
  }

  before do
    sign_in customer
  end

  describe 'UPDATE photo' do
    let(:photo) { FactoryBot.create(:photo) }

    it 'redirects to customer photos path with success notice' do
      patch :update, params: { id: photo.id, photo: { title: 'New Title' } }
      expect(flash[:notice]).to eq("編集の更新に成功しました！")
    end
  end

  describe 'CREATE photo' do
    context 'valid create' do
      it '投稿データの登録成功時' do
        post :create, params: { customer_id: 1, title: 'test', cat_color: '茶色', photo_introduction: 'testtest' }
        expect(flash[:notice]).to eq("写真の投稿に成功しました！")
      end
    end
  end
end
