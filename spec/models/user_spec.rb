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
      it 'nicknameが20文字以下のとき登録できる' do
        @user.nickname = 'ユーザー名'
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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it '重複したnicknameがある時登録できない' do
        @user.save
        user = FactoryBot.build(:user)
        user.nickname = @user.nickname
        user.valid?
        expect(user.errors.full_messages).to include('ニックネームはすでに存在します')
      end
      it 'nicknameが20文字を超える時登録できない' do
        @user.nickname = 'アイウエオかきくけこサシスセソたちつてとナニヌネノ'
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームは20文字以内で入力してください')
      end
      it 'fan_team_idが存在しない時登録できない' do
        @user.fan_team_id = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("ファンチームを入力してください")
      end
      it 'emailが空の時登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end
      it '重複したemailがある時登録できない' do
        @user.save
        user = FactoryBot.build(:user)
        user.email = @user.email
        user.valid?
        expect(user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'emailに@が含まれない時登録できない' do
        @user.email = 'furimagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end
      it 'passwordが空の時登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下の時登録できない' do
        @user.password = '11ee'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが半角英字のみの時登録できない' do
        @user.password = 'eeeeee'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end
      it 'passwordが半角数字のみの時登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英数字で入力してください')
      end
      it 'passwordが存在してもpassword_confirmationが空の時登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'passwordとpassword_confirmationが一致しない時登録できない' do
        @user.password = '111eee'
        @user.password_confirmation = 'eee111'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
    end
  end
end
