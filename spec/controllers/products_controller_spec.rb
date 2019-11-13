require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #new" do
    context "管理者ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        product = FactoryBot.create(:product)
        get :new, params: { "id" => product.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        product = FactoryBot.create(:product)
        get :new, params: { "id" => product.id}, session: {"user_id" => @user.id}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :new, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #index" do
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, password: "nominomi1")
        get :index, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "ホーム画面に遷移する" do
        expect(response).to have_http_status(200)
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :index, params: { "id" => product.id}, session: {}
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #mens" do
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, password: "nominomi1")
        gender = FactoryBot.create(:gender, id: "1", gender_name: "Mens")
        get :mens, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
  end
end
