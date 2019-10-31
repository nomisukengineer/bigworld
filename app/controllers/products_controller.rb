class ProductsController < ApplicationController
  def new
  end

  def show
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.paginate(page: params[:page])
  end

  def show_size
    @feed 
  end


end
