class ProductsController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
    @product = Product.find(params[:id])
#    @size_ids = Product.find(params[:id]).wares.pluck("size_id").uniq
#    @size_ids = get_size_ids(params[:id])
    @size_ids = Product.get_size_ids(params[:id])
  end

  def index
    @products = Product.paginate(page: params[:page])
  end



end
