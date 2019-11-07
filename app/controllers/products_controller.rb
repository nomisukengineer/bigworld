class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :new, :create, :index, :destroy, :show, :mens, :ladies, :analytics]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :orderd_product, only: :destroy

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "商品が追加されました。"
      # 保存の成功をここで扱う。
      redirect_to products_path
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

  end

  def index
    @products = Product.paginate(page: params[:page]).search(params[:search])
    @mens = Gender.find(1)
    @ladies = Gender.find(2)
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

  def destroy
    @product_id = Product.find(params[:product_id]).id
    @size_id = Size.find(params[:size_id]).id
    #debugger
    #product = Product.find(id)
    id = Ware.where("product_id = #{@product_id} and size_id = #{@size_id}").ids[0]
    Ware.find(id).update(:amount => nil)
    redirect_to root_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  private

    def product_params
      params.require(:product).permit(:product_name, :gender_id, :category_id,
             :price)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation,
                                  :birthday, :postcode, :address,
                                  :creditcard, :creditpass)
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
      
      # 正しいユーザーかどうか確認
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end
    
      def orderd_product
      end

end
