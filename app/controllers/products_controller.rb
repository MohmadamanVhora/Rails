class ProductsController < ApplicationController
  layout 'header'
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    binding.pry
    @product = Product.new
  end

  def create
    binding.pry
    @product = Product.new(product_params)
  
    if @product.save
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:name, :category, :price, :description)
  end
end
