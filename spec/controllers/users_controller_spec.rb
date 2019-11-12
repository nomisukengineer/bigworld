require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success[241]" do
      get :new
      expect(response).to have_http_status(:success)
    end

    # 200レスポンスを返すこと
    it "returns a 200 response[242]" do
      #sign_in @user
      get :new
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #show" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user, password: "nominomi1")
        get :show, params: {"id" => @user.id}, session: {"user_id" => @user.id}
      end

      it "returns http success[243]" do
        expect(response).to have_http_status(:success)
      end
      it "returns a 200 response[244]" do
        expect(response).to have_http_status "200"
      end
    end


    context "as a guest" do
      before do
        fake_id = 1
        get :show, params: {"id" => fake_id}, session: {}
      end
      it "returns a 302 response[245]" do
        expect(response).to have_http_status "302"
      end

      it "returns a 302 response[246]" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "POST #create" do
    context "入力する値に間違いがない" do
      before do
        @user = FactoryBot.build(:user, password: "nominomi1")
        @count = User.count
        post :create, params: {user: {name: "MyString",
                                      email: "nominomi@gmail.com", 
                                      password: "foobar", 
                                      password_comfirmation: "foobar", 
                                      birthday: "2019-10-29",
                                      creditcard: "123455678",
                                      creditpass: "123",
                                      postcode: "1234567",
                                      address:"東京都"}}, session: {}
      end

      it "add new user[247]" do
        expect(@count).to eq (User.count - 1)

      end
      it "returns a 302 response[248]" do
        expect(response).to have_http_status "302"
      end
      it "ホーム画面に遷移すること[249]" do
        expect(response).to redirect_to root_path
      end
    end
    context "入力した値が保存されない場合" do
      before do
        @user = FactoryBot.build(:user, password: "nominomi1")
        @count = User.count
        post :create, params: {user: {name: "MyString",
                                      email: "invalid", 
                                      password: "foobar", 
                                      password_comfirmation: "foobar", 
                                      birthday: "2019-10-29",
                                      creditcard: "123455678",
                                      creditpass: "123",
                                      postcode: "1234567",
                                      address:"東京都"}}, session: {}
      end
      it "returns a 200 response[250]" do
        expect(response).to have_http_status "200"
      end
      it "サインアップ画面に遷移すること[251]" do
        expect(response).to render_template 'new'
      end
      it "ホーム画面に遷移しないこと[22]" do
        expect(response).not_to redirect_to root_path
      end
    end
  end

  describe "PATCH #update" do
  context "ログインユーザーである場合" do
    before do
      @user = FactoryBot.create(:user, password: "nominomi1")
      @params =  {id: "1", user: {
        name: "MyString",
        email: "invalid", 
        password: "foobar", 
        password_comfirmation: "foobar", 
        birthday: "2019-10-29",
        creditcard: "123455678",
        creditpass: "124",
        postcode: "1234567",
        address:"東京都"}}
      patch :update, params: @params, session: {user_id: @user.id}
    end
    it "更新に成功すること" do
      expect(@user.name).to eq @params[:user][:name]
      expect(response).to redirect_to @user
    end
  end
end


  describe "GET #carts"

  describe "POST #create_carts"

  describe "DELETE #destroy_carts"

  describe "GET #orders"

  describe "POST #create_orders"

  describe "DELETE #destroy_orders"

  describe "GET #favorites"

  describe "POST #create_favorites"

  describe "DELETE #destroy_favorites"

  describe "POST #thankyou"
end
