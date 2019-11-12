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

=begin
  describe "GET #create" do
    before do
      @user = FactoryBot.create(:user, password: "nominomi1")
    end

    it "returns http success" do
      post '/login'
      expect(response).to have_http_status(:success)
    end
  end
=end
end
