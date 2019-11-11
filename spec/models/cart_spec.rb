require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "一つのuser情報を持つこと[147]" do
    it {is_expected.to belong_to(:user)}
  end

  describe "一つのware情報を持つこと[148]" do
    it {is_expected.to belong_to(:ware)}
  end
end
