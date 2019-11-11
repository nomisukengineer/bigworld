require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "一つののcategoryを持つこと[121]" do
    it {is_expected.to belong_to(:category)}
  end

  describe "一つののgenderを持つこと[122]" do
    it {is_expected.to belong_to(:gender)}
  end

  describe "複数のwaresを持つこと[123]" do
    it {is_expected.to have_many(:wares)}
  end

  describe "複数のfavoritesを持つこと[124]" do
    it {is_expected.to have_many(:favorites)}
  end

  describe "productの文字数は30文字[125]" do
    it { is_expected.to validate_presence_of(:product_name) }
    it { is_expected.to validate_length_of(:product_name).is_at_most(30) }
  end


  describe "productからwareを通じてsizeを取ってこれること[126]" do
    let!(:gender) { create(:gender) }
    let!(:category) { create(:category) }
    let!(:product) { create(:product, gender: gender, category: category) }
    let!(:size) { create(:size) }
    let!(:ware) { create(:ware, product: product, size: size) }
    it "productからwareを通じてsizeを取ってこれること" do
      a=Product.find(product.id).wares.pluck(:size_id)
      b=Product.get_size_ids(product.id)
      # binding.pry
      expect(a).to eq([size.id])
    end
  end

  describe "検索結果を表示できること" do
    let!(:gender) { create(:gender) }
    let!(:category) { create(:category) }
    let!(:product) { create(:product, product_name: "あいうえお", gender: gender, category: category) }
    let!(:product) { create(:product, product_name: "あかさたな", gender: gender, category: category) }
    let!(:product) { create(:product, product_name: "いきいきTシャツ", gender: gender, category: category) }

      it "検索が行われた場合[127]" do
        search = "あ"
        products = Product.search("あ")
        expect(products).to eq Product.where(['product_name LIKE ?', "%#{search}%"])
      end

      it "検索が行われた場合[128]" do
        search = nil
        products = Product.search(nil)
        expect(products).to eq Product.all
      end
    end


end