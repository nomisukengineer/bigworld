require 'rails_helper'

RSpec.describe Gender, type: :model do
  describe "複数のproductsを持つこと[142]" do
    it {is_expected.to have_many(:products)}
  end
end
