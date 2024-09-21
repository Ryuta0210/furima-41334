require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザーの新規登録' do
    context '新規登録できる場合' do
      it '各フォーマットで指定された文字の種類が正しく、情報が揃っていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'family_kana_nameが空では登録できない' do
        @user.family_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family kana name can't be blank")
      end

      it 'first_kana_nameが空では登録できない' do
        @user.first_kana_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First kana name can't be blank")
      end

      it '生年月日が空では登録できない' do
        @user.birth_day = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth day can't be blank")
      end

      it '@を含まないemailは登録できない' do
        @user.email = @user.email.gsub('@', '')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordは半角英数字がそれぞれ1文字ずつ含まれていないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は英数字を1文字以上ずつ入力してください')
      end

      it 'passwordは5字以下だと登録できない' do
        @user.password = '12345'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは129字以上だと登録できない' do
        @user.password = Faker::Internet.password(min_length: 130, max_length: 131)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameは、全角（漢字・ひらがな・カタカナ）以外での登録はできない' do
        invalid_family_names = ['aaa', 'AAA', '123', '@@@', '   ']
        invalid_family_names.each do |invalid_family_name|
          @user.family_name = invalid_family_name
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name は全角の漢字・ひらがな・カタカナで入力してください')
        end
      end

      it 'first_nameは、全角（漢字・ひらがな・カタカナ）以外での登録はできない' do
        invalid_first_names = ['aaa', 'AAA', '123', '@@@', '   ']
        invalid_first_names.each do |invalid_first_name|
          @user.first_name = invalid_first_name
          @user.valid?
          expect(@user.errors.full_messages).to include('First name は全角の漢字・ひらがな・カタカナで入力してください')
        end
      end

      it 'family_kana_nameは、全角カタカナ以外での登録はできない' do
        invalid_kana_family_names = ['aaa', 'AAA', '123', '@@@', '   ', '田中', 'たなか']
        invalid_kana_family_names.each do |invalid_family_kana_name|
          @user.family_kana_name = invalid_family_kana_name
          @user.valid?
          expect(@user.errors.full_messages).to include('Family kana name は全角のカタカナで入力してください')
        end
      end

      it 'first_kana_nameは、全角カタカナ以外での登録はできない' do
        invalid_kana_first_names = ['aaa', 'AAA', '123', '@@@', '   ', '田中', 'たなか']
        invalid_kana_first_names.each do |invalid_first_kana_name|
          @user.first_kana_name = invalid_first_kana_name
          @user.valid?
          expect(@user.errors.full_messages).to include('First kana name は全角のカタカナで入力してください')
        end
      end
    end
  end
end
