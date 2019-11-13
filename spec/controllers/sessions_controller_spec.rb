require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "returns a 200 response" do
      get :new
      expect(response).to have_http_status "200"
    end
  end


  describe "POST #create" do
    context "メールアドレスとパスワードの組み合わせが正しい場合" do
      before do
        @user = FactoryBot.create(:user, email: "nomi@gmail.com", password: "nominomi1")
        post :create,
        params:{id: @user.id, session: {email: @user.email, password: @user.password, remember_me: "0"}}, 
        session: {}
      end
      it "302レスポンスが返ってくる" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面にリダイレクトする" do
        expect(response).to redirect_to root_path
      end
    end
    context "メールアドレスとパスワードの組み合わせが間違っている場合" do
      before do
        @user = FactoryBot.create(:user, email: "nomi@gmail.com", password: "nominomi1")
        post :create,
        params:{id: @user.id, session: {email: @user.email, password: "foobar", remember_me: "0"}}, 
        session: {}
      end
      it "ログインページから正常なレスポンスがあること" do
        expect(response).to have_http_status(200)
      end
      it "ログインページに遷移すること" do
        expect(response).to render_template("sessions/new")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = FactoryBot.create(:user, email: "nomi@gmail.com", password: "nominomi1")
      delete :destroy,
      params:{id: @user.id, session: {email: @user.email, password: @user.password, remember_me: "0"}}, 
      session: {}
    end
    it "ログアウト後、ホーム画面に遷移する" do
      expect(response).to redirect_to root_path
    end
  end
end
