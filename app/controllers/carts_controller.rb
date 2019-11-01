class CartsController < ApplicationController
  def new
    cart = Cart.new
  end

  def create
    cart = Cart.new
  end

  def show

#    @cart = Cart.find(params[:id])
#    @user = Cart.user.find(params[:id])
#    @cart_ids = User.find(params[:id]).carts.ids
#    @ware_ids = Cart.find(params[:ids]).wares.pluck("ware_id")
#    @ware_ids = Ware.get_ware_ids(params[:ids])

  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,
                                  :birthday, :postcode, :address,
                                  :creditcard, :creditpass)
    end

    def correct_user
      @cart = current_user.carts.find_by(id: params[:id])
      redirect_to root_url if @cart.nil?
    end
end
