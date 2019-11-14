require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  include SessionsHelper
  describe "log_in(user)" do
    before do
      @user = FactoryBot.create(:user, id: "1")
    end
    it "渡されたユーザーでログインすること" do
      log_in(@user)
      expect(session[:user_id]).to eq (@user.id)
    end
  end

  describe "remember(user)" do
    before do
      @user = FactoryBot.create(:user, id: "1")
    end
    it "クッキーにparamsでユーザーidを保存できること" do
      remember(@user)
      expect(cookies.permanent.signed[:user_id]).to eq (@user.id)
    end
    it "クッキーにparamsでユーザーidを保存できること" do
      remember(@user)
      expect(cookies.permanent.signed[:user_id]).to eq (@user.id)
    end
  end

  describe "current_user?(user)" do
  end
  
  describe "current_user" do
    context "ログイン済みユーザーの場合" do
      before do
        @user2 = FactoryBot.create(:user, id: "2")
        session = {user_id: @user2.id}
        # get :show, params: { id: @user2.id }, session: {user_id: @user2.id}
      end
      it "データベースから取ってきて返す" do
        log_in @user2
        expect(current_user).to eq User.find_by(id: @user2.id)
      end
    end
    context "rememberユーザーの場合" do
      before do
        @user3 = FactoryBot.create(:user, id: "3", remember_digest: "m4DlEXadjk3bNCiUPl9a_g")
        session = {user_id: @user3.id}
        @user3.id = cookies.signed[:user_id]
      end
      it "cookieの記憶トークンとuserが一致していれば、ログインして対応するユーザーを返す" do
        # debugger
        log_in @user3
        expect(current_user).to eq User.find_by(id: @user3.id)
        log_in @user3
        expect(current_user).to eq @user3
      end
    end
  end

  describe "current_user?(user)" do
    context "ログイン済みユーザーの場合" do
      before do
        @user = FactoryBot.create(:user, id: "1")
        session = {user_id: @user.id}
        # get :show, params: { id: @user2.id }, session: {user_id: @user2.id}
      end
      it "trueを返すこと" do
        log_in @user
        expect(current_user?(@user)).to eq true
      end
    end
    context "ゲストユーザーの場合" do
      before do
        @user = FactoryBot.create(:user, id: "1")
        # get :show, params: { id: @user2.id }, session: {user_id: @user2.id}
      end
      it "falseを返すこと" do
        expect(current_user?(@user)).to eq false
      end
    end
  end

  describe "logged_in?" do
    context "ログインしたユーザー" do
      before do
        @user = FactoryBot.create(:user, id: "1", admin: nil)
        session = {user_id: @user.id}
      end
      it "trueを返すこと" do
        log_in @user
        expect(logged_in?).to eq true
      end
    end
    context "ゲストユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, id: "1")
        session = {}
      end
      it "trueを返すこと" do
        expect(logged_in?).to eq false
      end
    end


    describe "forget(user)" do
      context "ログインしたユーザー" do
        before do
          @user = FactoryBot.create(:user, id: "1", admin: nil)
          session = {user_id: @user.id}
        end
        it "cookieの中身をnilにする" do
          log_in @user
          forget(@user)
          expect(cookies.signed[:user_id]).to eq nil
        end
      end
      context "ゲストユーザーである場合" do
        before do
          @user = FactoryBot.create(:user, id: "1")
          session = {}
        end
        it "trueを返すこと" do
          expect(logged_in?).to eq false
        end
      end
    end
    describe "log_out" do
      context "ログインしたユーザー" do
        before do
          @user = FactoryBot.create(:user, id: "1", admin: nil)
          session = {user_id: @user.id}
        end
        it "trueを返すこと" do
          log_in @user
          log_out
          expect(@current_user).to eq nil
        end
      end
    end

    describe "redirect_back_or" do
      context "ログインしたユーザー" do
        before do
          # @user = FactoryBot.create(:user, id: "1", admin: nil)
          session = {user_id: @user.id, forwarding_url: "/"}
        end
        it "trueを返すこと" do
          log_in @user
          
          expect(@current_user).to eq nil
        end
      end
    end
  end

  # describe "admin?" do
  #   context "ログイン済みユーザーの場合" do
  #     before do
  #       @user2 = FactoryBot.create(:user, id: "2")
  #       get :show, params: { id: @user2.id }, session: {user_id: @user2.id}
  #     end
  #     it "データベースから取ってきて返す" do
  #       expect(current_user).to eq User.find_by(id: @user2.id)
  #     end
  #   end
  #   context "rememberユーザーの場合" do
  #     before do
  #       @user3 = FactoryBot.create(:user, id: "3", remember_digest: "m4DlEXadjk3bNCiUPl9a_g")
  #     end
  #     it "cookieの記憶トークンとuserが一致していれば、ログインして対応するユーザーを返す" do
  #       # debugger
  #       expect(@current_user).to eq @user3
  #     end
  #   end
  # end
end
