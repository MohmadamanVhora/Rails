class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @product_id = Product.unscoped.find(params[:product_id]).id
    @order = Order.new
  end

  def create
    product = Product.unscoped.find(order_params[:product_id])
    @order = product.orders.new(order_params)
    if @order.save
      redirect_to @order
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product_id = Product.unscoped.find(@order.product_id).id
  end

  def update
    product = Product.unscoped.find(order_params[:product_id])
    @order = product.orders.find(params[:id])
    if @order.update(order_params)
      redirect_to @order
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path, status: :see_other
  end

  def filter
    @orders = Order.where(quantity: params[:quantity])
    render :index
  end

  def search
    products = Product.unscoped.where("lower(title) Like ?", "%#{params[:title].downcase}%")
    @orders_by_product_name = Order.where(product_id: products.ids)
    render :index
  end

  private
  def order_params
    params.require(:order).permit(:quantity, :order_status, :product_id, :customer_id)
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
