require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  describe "GET /users_logins" do
    it "works! (now write some real specs)" do
       get login_path
       post login_path, params: { session: { email: "", password: "" } }
       expect(response).to have_http_status(200)
       get root_path
    end
  end


  describe "フラッシュメッセージ" do
    it "login with invalid information" do
      get login_path
      assert_template 'sessions/new'
      post login_path, params: { session: { email: "", password: "" } }
      assert_template 'sessions/new'
      expect(flash.empty?).to_not eq true
      get root_path
      assert flash.empty?
    end
  end
end

