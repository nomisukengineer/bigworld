class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :show, :edit, :update, :carts, :create_carts, :destroy_carts, :orders, :orders_history, :favorites, :create_favorites, :destroy_favorites, :thankyou]
  before_action :correct_user,   only: [:edit, :update, :show]
  protect_from_forgery
  def show
    @user = User.find(session[:user_id])
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
    #@ware_ids = @user.carts.pluck("ware_id")
  end


  def create_carts
    @user = User.find(session[:user_id])
    @product = Product.find(params[:product_id])
    @size_id = Size.find(params[:size_id])
    #debugger
    # @ware = Ware.where("product_id = #{@product.id} and size_id = 1")
    id = Ware.where("product_id = #{@product.id} and size_id = #{@size_id.id}").ids[0]
    @ware=Ware.find(id)
    Cart.create!(user_id: @user.id, ware_id: @ware.id, cart_count: 1)
    redirect_to "/users/#{@user.id}/carts"
  end

  def destroy_carts
    @user = User.find(session[:user_id])
    id = Cart.find_by(params[:cart_id]).id
    cart = Cart.find(id)
    cart.destroy
    redirect_to "/users/#{@user.id}/carts"
  end

  def orders
    @user = User.find(session[:user_id])
    @carts = @user.carts
  end

  def orders_history
    @user = User.find(session[:user_id])
    @orders = @user.orders
  end

  def favorites
    @user = User.find(session[:user_id])
    @favorites = @user.favorites
  end

  def create_favorites
    @user = User.find(session[:user_id])
    @product = Product.find(params[:product_id])

    Favorite.create!(user_id: @user.id, reaction_id: 1, product_id: @product.id)
    redirect_to "/users/#{@user.id}/favorites"
  end

  def destroy_favorites
    @user = User.find(session[:user_id])
    id = Favorite.find_by(params[:favorite_id]).id
    favorite = Favorite.find(id)
    favorite.destroy
    redirect_to "/users/#{@user.id}/favorites"
  end

  def thankyou
    input_user = User.find_by(creditcard: params[:creditcard])

    if input_user.creditpass != params[:user][:creditpass]
      redirect_back
    else
      # ユーザーログイン後にホームのページにリダイレクトする
      @user = User.find(session[:user_id])
      @ware_ids = @user.carts.pluck("ware_id")
      #debugger

      #id = Ware.where("product_id = #{@product.id} and size_id = 1").ids[0]
      #@ware=Ware.find(id)
      begin
        ActiveRecord::Base.transaction(requires_new: true) do
          
          @ware_ids.each do |ware_id|
            @order = Order.create!(user_id: @user.id, ware_id: ware_id, order_count: 1)
            Ware.find(ware_id).update(:amount => Ware.find(ware_id).amount -=1)
            Cart.find_by("user_id = #{@order.user_id} and ware_id = #{@order.ware_id}").destroy
          end
          redirect_to "/users/#{@user.id}/orders_history"

      rescue => e
          ActiveRecord::Rollback
          flash[:danger] = 'there are no stock'
          redirect_to "/users/#{@user.id}/carts"
        end
      end
    end
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

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
