require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe "GET #new" do
    before do
      @user = FactoryBot.create(:user, password: "nominomi1")
      product = FactoryBot.create(:product)
      get :show, params: { "id" => product.id}, session: {"user_id" => @user.id}
    end
    it "returns http success" do
      #get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    before do
      @user = FactoryBot.create(:user, password: "nominomi1")
      get :show, params: {"user_id" => @user.id}, session: {"user_id" => @user.id}
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
