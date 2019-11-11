require 'rails_helper'


RSpec.describe "User pages", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  # 他のアクションのテストは省略

  describe "#create" do
    include ActiveJob::TestHelper

    it "is invalid with invalid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "",
                                            email: "user@invalid",
                                            password: "foo",
                                            password_confirmation: "bar" } }
        }.to_not change(User, :count)
      end
    end

    it "is valid with valid signup information" do
      perform_enqueued_jobs do
        expect {
          post users_path, params: { user: { name: "ExampleUser",
                                            email: "user@example.com",
                                            password: "password",
                                            password_confirmation: "password" } }
        }.to change(User, :count).by(0)

        expect(response).not_to redirect_to root_path
        user = assigns(:user)    # gem 'rails-controller-testing'をインストール
        # 有効化していない状態でログインしてみる
        #sign_in_as(user)
        #expect(session[:user_id]).to be_falsey
      end
    end
  end
end

=begin
RSpec.describe "Home page", type: :request do
  # 正常なレスポンスを返すこと
  it "responds successfully" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
  end
end
=end

RSpec.describe "New page", type: :request do
  # 正常なレスポンスを返すこと
  it "responds successfully" do
      get new_user_path
      expect(response).to be_success
      expect(response).to have_http_status "200"
  end
end
