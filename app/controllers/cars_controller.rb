class CarsController < ApplicationController
  http_basic_authenticate_with name: "Aman", password: "password"
  before_action :find_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = Car.all
    
    if current_user == nil
      flash[:alert] = "Please Login to access your Cars!"
      render 'shared/login_page'
    end   
  end

  def show
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
  
    if @car.save
      redirect_to @car
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @car.update(car_params)
      redirect_to @car
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car.destroy 
    redirect_to cars_path, status: :see_other
  end

  def search
    @cars = Car.where("lower(company) LIKE ?", "%#{params[:company].downcase}%")
    render :index
  end

  def download_pdf
    user = current_user
    send_data generate_pdf(user), 
              filename: "#{user.username}.pdf", 
              type: 'application/pdf' 
  end
  
  private
  
  def car_params
    params.require(:car).permit(:name, :company, :price)
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def generate_pdf(user)
    pdf = Prawn::Document.new
    table_data = [] 
    table_data << %w[Carname Company Price]
    pdf.text "Hello, #{user.username.titleize}", align: :center, size: 20, style: :bold
    Car.all.each do |car| 
      table_data << [car.name, car.company, car.price] 
    end 
    
    pdf.table(table_data, width: 500, header: true, position: :center)
    pdf.render
  end
end
