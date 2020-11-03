require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録がうまく行く時' do
      it 'nickname, fan_team_id, email, password, password_confirmationが存在するとき登録できる' do
        expect(@user).to be_valid
      end
      it 'emailが@を含むとき登録できる' do
        @user.email = 'baseball@gmail.com'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ半角英数字混合で登録できる' do
        @user.password = '111eee'
        @user.password_confirmation = '111eee'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない時' do
      it 'nicknameが存在しない時登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it '重複したnicknameがある時登録できない' do
        @user.save
        user = FactoryBot.build(:user)
        user.nickname = @user.nickname
        user.valid?
        expect(user.errors.full_messages).to include('Nickname has already been taken')
      end
      it 'fan_team_idが存在しない時登録できない' do
        @user.fan_team_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Fan team must exist")
      end
      it 'emailが空の時登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailがある時登録できない' do
        @user.save
        user = FactoryBot.build(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに@が含まれない時登録できない' do
        @user.email = 'furimagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空の時登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下の時登録できない' do
        @user.password = '11ee'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英字のみの時登録できない' do
        @user.password = 'eeeeee'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordが半角数字のみの時登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'passwordが存在してもpassword_confirmationが空の時登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しない時登録できない' do
        @user.password = '111eee'
        @user.password_confirmation = 'eee111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
end
