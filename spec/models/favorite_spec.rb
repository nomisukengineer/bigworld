require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe "一つのreaction情報のを持つこと[144]" do
    it {is_expected.to belong_to(:reaction)}
  end

  describe "一つのuser情報のを持つこと[145]" do
    it {is_expected.to belong_to(:user)}
  end

  describe "一つのproduct情報のを持つこと[146]" do
    it {is_expected.to belong_to(:product)}
  end
end
