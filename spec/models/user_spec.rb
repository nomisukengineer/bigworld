require 'rails_helper'

RSpec.describe User, type: :model do

    describe "全て正しく入力された場合" do
        #姓、名、メール、パスワードがあれば有効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
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
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
                creditpass: "123"
                )
            expect(user).to be_valid
        end

        it "is valid with 50 characters" do
            user = User.new(
                name: "a"*50,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
                creditpass: "123"
                )
            expect(user).to be_valid
        end

        it "is invalid with 51 characters" do
            user = User.new(
                name: "a"*51,
                email: "nomi@gmail.com",
                password: "password",
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 半角name" do
            user = User.new(
            name: "ﾉﾐｽｹ",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 英数字name" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )

            user = User.new(
            name: "nomitakeshi",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
        end

        it "is invalid when password is 5 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passw",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to_not be_valid
        end

        it "is valid when password is 6 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "passwo",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            user.valid?
            expect(user).to be_valid
        end
    end

    describe "生年月日" do
        #生年月日がなくても有効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: nil,
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996/12/156",
            creditcard: "1234-5678-9012-3456",
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
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            user.valid?
            expect(user.errors[:postcode]).to include("can't be blank")
        end
    end

    describe "住所" do
        #住所がなければ無効な状態であること
        it "is valid with a first name, last name, email, password, postdode, address, creditcard, creditpass" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: nil,
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "a"*254,
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with with 255 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "a"*255,
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-345",
            creditpass: "123"
            )
            expect(user).to be_valid
        end

        it "is valid with 20 characters" do
            user = User.new(
            name: "nomisuke",
            email: "nomi@gmail.com",
            password: "password",
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
            postcode: "123-4567",
            address: "東京都中央区銀座6丁目10",
            birthday: "1996-12-15",
            creditcard: "1234-5678-9012-3456",
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
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
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
                postcode: "123-4567",
                address: "東京都中央区銀座6丁目10",
                birthday: "1996-12-15",
                creditcard: "1234-5678-9012-3456",
                creditpass: "123"
            )
            expect(user).to be_valid
        end
    end


=begin
        it "is invalid with 4 characters " do
            user = User.new(
                name: "nomisuke",
                email: "nomi@gmail.com",
                password: "password",
                postcode: "123-4567",
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
end
