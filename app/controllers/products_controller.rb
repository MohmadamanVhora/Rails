class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.unscoped.all
  end
  
  def active_products
    @products = Product.all
    render :index
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :capacity, :is_active, :product_status)
  end

  def find_product
    @product = Product.unscoped.find(params[:id])
  end
end
