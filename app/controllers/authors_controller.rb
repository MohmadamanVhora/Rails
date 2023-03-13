class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  before_action :find_author, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
  
    if @author.save
      redirect_to @author
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @author.update(author_params)
      redirect_to @author
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy

    redirect_to authors_path, status: :see_other
  end

  private
  def author_params
    params.require(:author).permit(:first_name, :last_name, :date_of_birth, :email)
  end

  def find_author
    @author = Author.find(params[:id])
  end
end
