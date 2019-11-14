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
        get :new, params: { "id" => @user.id}, session: {"user_id" => @user.id}
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
        get :new, params: { "product_id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #create" do
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, id: "1", admin: true)
        gender = FactoryBot.create(:gender, id: "1", gender_name: "Mens")
        category = FactoryBot.create(:category, id: "1", category_name: "パーカー")
        @product = FactoryBot.create(:product, id: "1")
        @product_params = { id: "1", product_name: "僕のパーカー", gender_id: "1", category_id: "1", price: "100"}
        get :create, params: {id: @user.id, product: @product_params}, session: {"user_id" => @user.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to "/products/2"
      end
    end

    context "ログインユーザーであり、productが保存されない場合" do
      before do
        @user = FactoryBot.create(:user, id: "1", admin: true)
        gender = FactoryBot.create(:gender, id: "1", gender_name: "Mens")
        category = FactoryBot.create(:category, id: "1", category_name: "パーカー")
        @product = FactoryBot.create(:product, id: "1")
        @product_params = { id: "1", product_name: "a"*31, gender_id: "1", category_id: "1", price: "100"}
        get :create, params: {id: @user.id, product: @product_params}, session: {"user_id" => @user.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(200)
      end
      it "ホーム画面に遷移する" do
        expect(response).to render_template("products/new")
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, id: "1", admin: nil)
        gender = FactoryBot.create(:gender, id: "1", gender_name: "Mens")
        category = FactoryBot.create(:category, id: "1", category_name: "パーカー")
        @product = FactoryBot.create(:product, id: "1")
        @product_params = { id: "1", product_name: "a"*31, gender_id: "1", category_id: "1", price: "100"}
        get :create, params: {id: @user.id, product: @product_params}, session: {"user_id" => @user.id}
        # product = FactoryBot.create(:product)
        get :create, params: { "id" => @product.id}, session: {}
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :create, params: { "id" => product.id}, session: {}
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #show" do
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, id: "1")
        @product = FactoryBot.create(:product, id: "1")
        get :show, params: {id: @user.id, product_id: @product.id}, session: {"user_id" => @user.id}
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
        get :show, params: { "id" => product.id}, session: {}
      end
      it "200レスポンスを返す" do
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
      it "302レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :index, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #ladies" do
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, password: "nominomi1")
        gender = FactoryBot.create(:gender, id: "2", gender_name: "Ladies")
        get :ladies, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :index, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #analytics" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        get :analytics, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        get :analytics, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "200レスポンスを返す" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :analytics, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #edit" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        get :edit, params: {"id" => @user.id, product_id: @product.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        @product = FactoryBot.create(:product, id: "1")
        get :edit, params: {"id" => @user.id, product_id: @product.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "200レスポンスを返す" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :edit, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #ware_new" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount:2)
        get :ware_new, params: {"id" => @user.id, product_id: @product.id, size_id: @size.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        @product = FactoryBot.create(:product, id: "1")
        get :edit, params: {"id" => @user.id, product_id: @product.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :edit, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #ware_create" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 0)
        @ware_amount = Ware.find(@ware.id).amount
        post :ware_create, params: {product_id: @product.id, ware: {product_id: @product.id, size_id: @size.id, amount: 1}}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(Ware.find(1).amount).to eq @ware_amount
      end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
    end
    
    context "管理ユーザーであり、保存が失敗する場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 0)
        @ware_amount = Ware.find(@ware.id).amount
        post :ware_create, params: {product_id: @product.id, ware: {product_id: @product.id, size_id: @size.size_name, amount: 1}}, session: {"user_id" => @user.id}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "returns http success" do
        expect(response).to redirect_to "/products/#{@product.id}/ware/new"
      end
    end

    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        @product = FactoryBot.create(:product, id: "1")
        get :edit, params: {"id" => @user.id, product_id: @product.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        product = FactoryBot.create(:product)
        get :edit, params: { "id" => product.id}, session: {}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "GET #ware_edit" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        @ware_amount = Ware.find(@ware.id).amount
        get :ware_edit, params: {product_id: @product.id, size_id: @size.id}, session: {"user_id" => @user.id}
      end
      # it "returns http success" do
      #   expect(Ware.find(1).amount).to eq @ware_amount
      # end
      it "200レスポンスを返す" do
        expect(response).to have_http_status(200)
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        get :ware_edit, params: {product_id: @product.id, size_id: @size.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: nil)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        get :ware_edit, params: {product_id: @product.id, ware: {size_id: @size.id, product_id: @product.id, amount: @ware.amount+1}}, session: {"user_id" => @user.id}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "PATCH #ware_update" do
    context "管理ユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: true)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        @ware_amount = Ware.find(@ware.id).amount
        patch :ware_update, params: {product_id: @product.id, ware: {size_id: @size.id, product_id: @product.id, amount: @ware.amount+1}}, session: {"user_id" => @user.id}
      end
      it "更新した数だけ在庫の量が増える" do
        expect(Ware.find(1).amount).to eq @ware_amount+1
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "商品ページにリダイレクトする" do
        expect(response).to redirect_to "/products/#{@product.id}"
      end
    end
    context "ログインユーザーである場合" do
      before do
        @user = FactoryBot.create(:user)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        get :ware_edit, params: {product_id: @product.id, size_id: @size.id}, session: {"user_id" => @user.id}
      end
      it "returns http success" do
        expect(response).to have_http_status(302)
      end
      it "ホーム画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
    context "ゲストユーザーである場合" do
      before do
        @user = FactoryBot.create(:user, admin: nil)
        @product = FactoryBot.create(:product, id: "1")
        @size = FactoryBot.create(:size, id: "1", size_name: "XL")
        @ware = FactoryBot.create(:ware, id: "1", product_id: "1", size_id: "1", amount: 1)
        get :ware_edit, params: {product_id: @product.id, size_id: @size.id}, session: {"user_id" => @user.id}
      end
      it "302レスポンスを返す" do
        expect(response).to have_http_status(302)
      end
      it "ログイン画面に遷移する" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
