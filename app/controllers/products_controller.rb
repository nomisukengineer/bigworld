class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    if @product.save
      flash[:success] = "商品が追加されました。"
      # 保存の成功をここで扱う。
      redirect_to products_path
    else
      debugger
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

  private

    def product_params
      params.require(:product).permit(:product_name, :gender_id, :category_id,
             :price)
    end

end
