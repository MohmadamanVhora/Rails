class CustomersController < ApplicationController
  before_action :find_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, status: :see_other
  end

  def task
    case params[:task_id]
    when '1'
      @customers = Customer.joins(:orders).order("SUM(quantity) DESC").group(:id).limit(3)
    when '2'
      @customers = Customer.joins(:orders).order("SUM(total_price) DESC").group(:id).limit(3)
    when '3'
      @customers = Customer.joins(:orders).where(orders: {order_status: 'booked'}).order('COUNT(customers.id) DESC').group(:id).limit(5)
    when '4'
      @customers = Customer.joins(:orders).where(orders: {order_status: 'canceled'}).order('COUNT(customers.id) DESC').group(:id).limit(5)
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone_number)
  end

  def find_customer
    @customer = Customer.find(params[:id])
  end
end
