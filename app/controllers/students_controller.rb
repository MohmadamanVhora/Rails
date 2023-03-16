class StudentsController < ApplicationController

  before_action :find_student, only: [:show, :edit, :update, :destroy]
  
  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
  
    if @student.save
      redirect_to @student
      flash.alert = "Email Validated"

    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to @student
      flash.alert = "Email Validated"

    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy

    redirect_to students_path, status: :see_other
  end

  private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :email, :date_of_birth, :department, :term_of_usage)
  end

  def find_student
    @student = Student.find(params[:id])
  end
end
