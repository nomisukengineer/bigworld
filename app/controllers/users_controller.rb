class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
  :following, :followers]
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 保存の成功をここで扱う。
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def carts
    @user = User.find(session[:user_id])
    @carts = @user.carts

  end

=begin
  def create_carts
    @user = User.find(session[:user_id])
    @product = Product.find(params[:id])
    @size_ids = Product.get_size_ids(params[:id])
    #debugger
    # @ware = Ware.where("product_id = #{@product.id} and size_id = 1")
    id = Ware.where("product_id = #{@product.id} and size_id = #{@size_id}").ids[0]
    @ware=Ware.find(id)
    # Cart.create!(user_id: @user.id, ware_id: @ware.pluck("id"), cart_count: 1)


    Cart.create!(user_id: @user.id, ware_id: @ware.id, cart_count: 1)
    redirect_to "/users/#{@user.id}/carts"
  end
=end

  def create_carts
    @user = User.find(session[:user_id])
    @product = Product.find(params[:id])
    @size_id = Size.find(params[:size_id])
    #debugger
    # @ware = Ware.where("product_id = #{@product.id} and size_id = 1")
    id = Ware.where("product_id = #{@product.id} and size_id = #{@size_id.id}").ids[0]
    @ware=Ware.find(id)
    
    Cart.create!(user_id: @user.id, ware_id: @ware.id, cart_count: 1)
    redirect_to "/users/#{@user.id}/carts"
  end

  def orders
    @user = User.find(params[:id])
    @carts = @user.carts
  end

  def orders_history
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation,
                                   :birthday, :postcode, :address,
                                   :creditcard, :creditpass)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
