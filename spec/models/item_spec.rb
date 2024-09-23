require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do
    context '商品登録できる場合' do
      it 'フォームに指定されているデータが揃っている場合登録ができる' do
        expect(@item).to be_valid
      end
    end

    context '商品登録できない場合' do
      it '画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image をアップロードしてください')
      end

      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Name を入力してください')
      end

      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Description を入力してください')
      end

      it 'カテゴリーが「---」では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end

      it '商品の状態が「---」では登録できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Status を選択してください')
      end

      it '配送料の負担が「---」では登録できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost を選択してください')
      end

      it '発送元の地域が「---」では登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture を選択してください')
      end

      it '発送までの日数が「---」では登録できない' do
        @item.delivery_schedule_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery schedule を選択してください')
      end

      it '販売価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Price を入力してください')
      end

      it '販売価格が300円未満では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で¥300〜¥9,999,999の間で設定してください')
      end

      it '販売価格が10,000,000円以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price は半角数字で¥300〜¥9,999,999の間で設定してください')
      end

      it '販売価格が数字以外では登録できない' do
        price_input = ['田中', 'たなか', 'タナカ', 'tanaka', '@@@', '   ', 'a12345']
        price_input.each do |input|
          @item.price = input
          @item.valid?
          expect(@item.errors.full_messages).to include('Price は半角数字で¥300〜¥9,999,999の間で設定してください')
        end
      end

      it 'userが紐づいていない状態では出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User が必要です')
      end
    end
  end
end
