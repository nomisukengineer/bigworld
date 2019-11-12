require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "一つのuser情報を持つこと[1410]" do
    it {is_expected.to belong_to(:user)}
  end

  describe "一つのware情報を持つこと[1411]" do
    it {is_expected.to belong_to(:ware)}
  end
end
