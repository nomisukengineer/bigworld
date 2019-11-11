require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe "複数のfavoritesを持つこと[143]" do
    it {is_expected.to have_many(:favorites)}
  end
end
