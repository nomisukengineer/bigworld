class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :new, :create, :index, :destroy, :show, :mens, :ladies, :analytics]
#  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy, :analytics, :ware_new, :ware_create, :ware_edit ,:ware_update]
  before_action :orderd_product, only: :destroy

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "商品が追加されました。"
      # 保存の成功をここで扱う。
      redirect_to "/products/#{@product.id}"
    else
      render 'new'
    end
  end

  def show
    @user = User.find(session[:user_id])
    @product = Product.find(params[:id])
#    @size_ids = Product.find(params[:id]).wares.pluck("size_id").uniq
#    @size_ids = get_size_ids(params[:id])
    @size_ids = Product.get_size_ids(params[:id])
    
    @ware1 = Ware.where("product_id = #{@product.id} and size_id =1").first
    @ware2 = Ware.where("product_id = #{@product.id} and size_id =2").first
    @ware3 = Ware.where("product_id = #{@product.id} and size_id =3").first
    @ware4 = Ware.where("product_id = #{@product.id} and size_id =4").first

  end

  def index
    @products = Product.paginate(page: params[:page]).search(params[:search])
  end

  def mens
    @mens_products = Gender.find(1).products.paginate(page: params[:page])
  end

  def ladies
    @ladies_products = Gender.find(2).products.paginate(page: params[:page])
  end

  def analytics
    @wares = Ware.all
    @products = Product.all
  end

  # def destroy
  #   @product_id = Product.find(params[:product_id]).id
  #   @size_id = Size.find(params[:size_id]).i
  #   #debugger
  #   #product = Product.find(id)
  #   id = Ware.where("product_id = #{@product_id} and size_id = #{@size_id}").ids[0]
  #   Ware.find(id).update(:amount => 0)
  #   redirect_to root_path
  # end

  def edit
    @product = Product.find(params[:id])
  end

  def ware_new
    @product = Product.find(params[:product_id])
    @size = Size.find(params[:size_id])
    # debugger
    @ware = Ware.new
  end

  def ware_create
    @product = Product.find(params[:product_id])
    @ware = Ware.new(ware_params)
      if @ware.save
        flash[:success] = "商品が変更されました"
        # 保存の成功をここで扱う。
        redirect_to "/products/#{@product.id}"
      else
        redirect_to "/products/#{@product.id}/ware/new"
      end
  end

  def ware_edit
    @product = Product.find(params[:product_id])
    @size_id = params[:size_id]
    @ware = Ware.where("product_id = #{@product.id} and size_id =#{@size_id}").first
    #Ware.find(@ware.id).update(:amount => Ware.find(@ware.id).amount)

  end

  def ware_update
    @product = Product.find(params[:product_id])
    @size = Size.find(params[:ware][:size_id])
    @ware = Ware.where("product_id = #{@product.id} and size_id =#{@size.id}").first
    Ware.find(@ware.id).update(:amount => params[:ware][:amount])
    redirect_to "/products/#{@product.id}"
  end

  private

    def ware_params
      params.require(:ware).permit(:product_id, :size_id,
             :amount)
    end

#    def ware_params
#      params.require(:ware).permit(:user_id, :size_id, :amount,
#             )
#    end

    # def user_params
    #   params.require(:user).permit(:name, :email, :password,
    #                               :password_confirmation,
    #                               :birthday, :postcode, :address,
    #                               :creditcard, :creditpass)
    # end

    def product_params
      params.require(:product).permit(:product_name, :gender_id, :category_id,
                                  :price)
    end

        # beforeフィルター

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end


      # 管理者かどうか確認
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
      
      # # 正しいユーザーかどうか確認
      # def correct_user
      #   @user = User.find(session[:id])
      #   redirect_to(root_url) unless current_user?(@user)
      # end


end
