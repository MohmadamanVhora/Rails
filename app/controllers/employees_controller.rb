class EmployeesController < ApplicationController
  before_action :find_employee, only: [:show, :update, :destroy, :change_order]
 
  def index
    @employees = Employee.all.order(id: :asc)
  end

  def show; end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.find_or_create_by(employee_params)
    unless @employee.email.blank?
      redirect_to @employee
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employee = Employee.find_or_initialize_by(id: params[:id])
    redirect_to new_employee_path unless @employee.first_name?
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy 
    redirect_to employees_path, status: :see_other
  end

  def search
    @employee = Employee.find_by(email: params[:email])
    unless @employee.nil?
      render :show
    else
      flash[:alert] = "Email Not Exists! Please Enter Valid Email"
      redirect_to employees_path
    end
  end

  def change_order
    if params[:order] == "decrement"
      @employee.decrement!(:no_of_order)
    elsif params[:order] == "increment"
      @employee.increment!(:no_of_order)
    end
    redirect_to employees_path
  end

  def first_ten_employees
    @employees = Employee.find_in_batches(batch_size: 10).first
    render :index
  end

  def task
    @options = [["age > 20 and < 40", 0], ["available_full_time", 1], ["no_of_order = 5 and age > 25", 2], ["created_before_today", 3], ["no_of_order = 5 and age < 25", 4], ["age_in_descending_order", 5], ["descending_order_by_no_of_orders", 6], ["salary_greater_than_45000", 7], ["group_order_and_order_greater_than_5", 8]]
    
    case params[:task]
    when "0"
      @employees = Employee.where('age > 20 and age < 40')
    when "1"
      @employees = Employee.where(full_time_available: true)
    when "2"
      @employees = Employee.where('no_of_order = 5 and age > 25')
    when "3"
      @employees = Employee.where(created_at: ..Date.today)
    when "4"
      @employees = Employee.where('no_of_order = 5 and age < 25')
    when "5"
      @employees = Employee.order(age: :desc)
    when "6"
      @employees = Employee.order(no_of_order: :asc)
    when "7"
      @employees = Employee.where('salary > ?', 45000)
    when "8" 
      @name_of_employee = {}
      Employee.group(:no_of_order).having('no_of_order > 5').pluck(:no_of_order).each do |order|
        @name_of_employee[order] = Employee.where(no_of_order: order).pluck(:first_name).join(", ")
      end
    else
      @employees = Employee.order(id: :asc)
    end  
  end
  
  private
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :age, :no_of_order, :full_time_available, :salary)
  end

  def find_employee
    @employee = Employee.find(params[:id])
  end
end
