class FacultiesController < ApplicationController

  before_action :find_faculty, only: [:show, :edit, :update, :destroy]
  
  def index
    @faculties = Faculty.all
  end


  def show
  end

  def new
    @faculty = Faculty.new
  end

  def create
    @faculty = Faculty.new(faculty_params)
  
    if @faculty.save
      redirect_to @faculty
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @faculty.update(faculty_params)
      redirect_to @faculty
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @faculty.destroy

    redirect_to faculties_path, status: :see_other
  end

  private
  def faculty_params
    params.require(:faculty).permit(:first_name, :last_name, :phone_no, :email, :date_of_birth, :designation)
  end

  def find_faculty
    @faculty = Faculty.find(params[:id])
  end
end
