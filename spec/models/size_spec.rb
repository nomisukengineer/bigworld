require 'rails_helper'

RSpec.describe Size, type: :model do
  describe "複数のwaresを持つこと[149]" do
    it {is_expected.to have_many(:wares)}
  end
end

