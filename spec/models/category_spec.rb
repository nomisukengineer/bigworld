require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "複数のproductsを持つこと[141]" do
    it {is_expected.to have_many(:products)}
  end
end
