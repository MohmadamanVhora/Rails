module Business
  class CustomersController < ApplicationController
    before_action :find_customer, only: [:preview, :edit, :update, :delete_customer]

    def index
      @customers = Customer.all
    end

    def preview; end

    def new
      @customer = Customer.new
    end

    def create
      @customer = Customer.new(customer_params)
      if @customer.save
        redirect_to preview_business_customer_path(@customer)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @customer.update(customer_params)
        redirect_to preview_business_customer_path(@customer)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def delete_customer
      @customer.destroy
      redirect_to business_customers_path, status: :see_other
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

    def search
      @customers = Customer.where("lower(first_name) Like ?", "%#{params[:name].downcase}%")
      return if @customers.nil?
      render :index
    end
    
    private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone_number)
    end

    def find_customer
      @customer = Customer.find(params[:id])
    end
  end
end
