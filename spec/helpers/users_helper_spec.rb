require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  include UsersHelper
    describe "gravatar_for(user)" do
      before do
        @user = FactoryBot.create(:user, id: "1")
      end
      it "gravatarが発行される" do
        expect(gravatar_for(@user)).to eq "<img alt=\"MyString\" class=\"gravatar\" src=\"https://secure.gravatar.com/avatar/#{Digest::MD5::hexdigest(@user.email.downcase)}\" />"
      end
    end
end
