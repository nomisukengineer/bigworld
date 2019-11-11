require 'rails_helper'

RSpec.describe Ware, type: :model do
  describe "一つのproduct情報を持つこと[131]" do
    it {is_expected.to belong_to(:product)}
  end

  describe "一つのsize情報を持つこと[132]" do
    it {is_expected.to belong_to(:size)}
  end

  describe "複数のcartを持つこと[133]" do
    it {is_expected.to have_many(:carts)}
  end

  describe "複数のorderを持つこと[134]" do
    it {is_expected.to have_many(:orders)}
  end
end

