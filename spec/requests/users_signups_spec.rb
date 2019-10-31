require 'rails_helper'

RSpec.describe "UsersSignups", type: :request do
  describe "GET /users_signups" do
    it "works! (now write some real specs)" do
      get signup_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

=begin
  describe "UserSignupsinformation" do
    it "valid signup information"
      expect(
        post users_path, params: { user: { name:  "Example User",
        email: "user@example.com",
        password:              "password",
        password_confirmation: "password" } }
      ).to change(User, :count).by(1)
      redirect_to @user
      follow_redirect!
      assert_template 'users/show'
  end
=end
end