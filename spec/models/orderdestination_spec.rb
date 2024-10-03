require 'rails_helper'
RSpec.describe OrderDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
  end

  describe '購入登録' do
    context '購入登録できる場合' do
      it '情報が揃っていれば登録できる' do
        expect(@order_destination).to be_valid
      end

      it 'Buildingが空でも登録できる' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '購入登録できない場合' do
      it 'tokenが空の場合、登録できない' do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Token を入力してください')
      end

      it 'post_codeが空の場合、登録できない' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code を入力してください')
      end

      it 'prefectureが「---」の場合、登録できない' do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Prefecture を選択してください')
      end

      it 'cityが空の場合、登録できない' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('City を入力してください')
      end

      it 'streetが空の場合、登録できない' do
        @order_destination.street = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Street を入力してください')
      end

      it 'phoneが空の場合、登録できない' do
        @order_destination.phone = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone を入力してください')
      end

      it 'item_idが空の場合、登録できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Item を入力してください')
      end

      it 'user_idが空の場合、登録できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('User を入力してください')
      end

      it 'post_codeは全角数字は登録できない' do
        @order_destination.post_code = '１２３-４５６７'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code は半角数字で半角の「-」を入力してください')
      end

      it 'post_codeは-がないと登録できない' do
        @order_destination.post_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Post code は半角数字で半角の「-」を入力してください')
      end

      it 'phoneは半角数字以外は登録できない' do
        @order_destination.phone = '１２３４５６７８９０'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone は半角数字で、10桁以上11桁以下で入力してください')
      end

      it '電話番号は10桁未満は登録できない' do
        @order_destination.phone = '123456'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone は半角数字で、10桁以上11桁以下で入力してください')
      end

      it '電話番号は12桁以上は登録できない' do
        @order_destination.phone = '123456789012'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include('Phone は半角数字で、10桁以上11桁以下で入力してください')
      end
    end
  end
end
