require 'rails_helper'

RSpec.describe User, type: :model do

    describe "全て正しく入力された場合" do
        #姓、名、メール、パスワードがあれば有効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end
    end

    describe "ユーザー名" do
        # ユーザー名がなければ無効な状態であること
        it "is invalid without user name" do
            user = User.new(
                name: nil,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
            )
            user.valid?
            expect(user.errors[:name]).to include("can't be blank")
        end

        #[長さ]ユーザー名の文字数が長すぎれば無効な状態であること
        it "is valid with 49 characters" do
            user = User.new(
                name: "a"*49,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
                )
            expect(user).to be_valid
        end

        it "is valid with 50 characters" do
            user = User.new(
                name: "a"*50,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
                )
            expect(user).to be_valid
        end

        it "is invalid with 51 characters" do
            user = User.new(
                name: "a"*51,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
                )
            user.valid?
            expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
        end

        it "is invalid with 52 characters" do
            user = User.new(
                name: "a"*52,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
                )
            user.valid?
            expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
        end

        #[フォーマット]名前が全角文字でも有効
        it "is valid with 全角name" do
            user = User.new(
            name: "のみすけ",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 半角name" do
            user = User.new(
            name: "ﾉﾐｽｹ",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 英数字name" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end
    end


    describe "メールアドレス" do
        # メールアドレスがなければ無効な状態であること
        it "is invalid without user name" do
            user = User.new(
                name: "nomisuke",
                email: nil,
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
            )
            user.valid?
            expect(user.errors[:email]).to include("can't be blank")
        end

        # 無効なメールアドレスの場合
        it "should be too long" do
            user = User.new(
            name: "nomitakeshi",
            email: "a"*255,
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to_not be_valid
        end


        #メールアドレスが重複している場合登録できないこと
        it "is invalid with a duplicate email address" do
            User.create(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )

            user = User.new(
            name: "nomitakeshi",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:email]).to include("has already been taken")
        end
    end

    describe "パスワード" do
        #パスワードがなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: nil,
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
        end

=begin
        it "is invalid when password is 5 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passw",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end
=end

        it "is 60 characters with password_digest[32]" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.save!
            expect(user.password_digest).not_to be_nil
            expect(user.password_digest.size).to eq(60)
        end


        it "is same password_digest when password is same[34]" do
#            user = User.new(
#            name: "nomisuke",
#            email: "nomi@gmail.com",
#            password: "password",
#            postcode: "1234567",
#            address: "東京都中央区銀座6丁目10",
#            birthday: "1996-12-15",
#            creditcard: "1234567890123456",
#            creditpass: "123"
#            )
            #SecureRandom.urlsafe_base64.length
            expect(SecureRandom.urlsafe_base64.size).to eq(22)
        end

        
        it "is true when password is true[35]" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.save!
            expect(user.remember_digest).to eq(nil)
            #expect(BCrypt::Password.new(remember_digest).is_password?(remember_token)).to.eq("true")
        end


        it "is valid when password is 5 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passwo",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to be_valid
        end

        it "is valid when password is 6 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passwo",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to be_valid
        end

        it "is valid when password is 7 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passwor",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to be_valid
        end
    end

    describe "生年月日" do
        #生年月日がなくても有効な状態であること
        it "is invalid without birthday" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: nil,
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end

        #誕生日がフォーマットや長さを満たさない場合無効
        it "is invalid with yyyy-mm-ddd" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996/12/156",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end

        it "is invalid with 数字以外" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "千九百九十六年",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end
    end

    describe "郵便番号" do
        #郵便番号がなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: nil,
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end


        it "is invalid with 7 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        #郵便番号がなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "一二三四五六",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:postcode]).to include("is not a number")
        end
    end

    describe "住所" do
        #住所がなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: nil,
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:address]).to include("can't be blank")
        end

        #[長さ]住所が256文字以上だと無効
        it "is valid with with 254 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "a"*254,
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with with 255 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "a"*255,
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

=begin
        it "is invalid with 256 characters" do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "123-4567",
                address: "a"*256,
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
                creditpass: "123"
            )
            user.valid?
            expect(user.errors[:address]).to include("is too long (maximum is 50 characters)")
        end
=end        
    end


    describe "クレジットカード番号" do
        #クレジットカード番号がなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: nil,
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:creditcard]).to include("can't be blank")
        end

        #クレジットカード番号がなければ無効な状態であること
        it "is valid with 19 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "19961215",
            creditcard: "123456789012345",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 20 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end
    end

    describe "暗証番号" do
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "1234567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234567890123456",
            creditpass: nil
            )
            user.valid?
            expect(user.errors[:creditpass]).to include("can't be blank")
        end
        
        # 暗証番号は3けた

        it "is invalid with 2 characters " do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "12"
            )
            user.valid?
            expect(user).to_not be_valid
        end


        it "is valid with 3 characters " do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 数字以外 " do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234567890123456",
                creditpass: "一二さん"
            )
            user.valid?
            expect(user).to_not be_valid
        end
    end


=begin
        it "is invalid with 4 characters " do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "1234567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
                creditpass: "1234"
            )
            user.valid?
            expect(user.errors[:creditpass]).to include("is too long (maximum is 3 characters)")
        end
    end
=end

    describe "永続セッションのためにユーザーをデータベースに記憶すること[35]" do
        let!(:user) { create(:user, name: "nomisuke", email: "nomi@gmail.com", password: "nominomi1",
                    postcode: "1234567", address: "東京都杉並区", creditcard: 123456, creditpass: 123) }
        it "デフォルトnilがnilじゃ無くなる[35]" do
            expect(user.remember_digest).to eq nil
            user.remember
            expect(user.remember_digest).not_to eq nil
        end
    end

    describe "渡されたトークンがnilの場合" do
        let!(:user) { create(:user, password: "nominomi1", remember_digest: nil) }
        it "falseを返す[36]" do
#            remember_token = "token"
            expect(user.authenticated?("token")).to eq (false)
        end
    end
    describe "渡されたトークンとダイジェストが一致した場合" do
        let!(:user) { create(:user, password: "nominomi1", remember_digest: User.digest("token")) }
        it "trueを返す[37]" do
            expect(user.authenticated?("token")).to eq (true)
        end
    end

    describe "ログイン情報が破棄された場合" do
        let!(:user) { create(:user, password: "nominomi1", remember_digest: "token") }
        it "remember_digestがnilにupdateされる[38]" do
            expect(user.remember_digest).to eq ("token")
            user.forget
            expect(user.remember_digest).to eq (nil)
        end
    end
end

