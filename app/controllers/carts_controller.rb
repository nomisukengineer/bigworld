class CartsController < ApplicationController
  def new
    cart = Cart.new
  end

  def show
    @user
  end
end
