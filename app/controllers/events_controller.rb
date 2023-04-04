class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]

  def index
    @events = Event.where(id: Enrollment.where(user_id: @current_user[:id], created: true).pluck(:event_id)).order(id: :desc)
  end

  def show
    @comments = Comment.where(event_id: @event.id)
    @likes = Like.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      Enrollment.create(event_id: @event.id, user_id: @current_user[:id], created: true)
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy 
    redirect_to events_path, status: :see_other
  end

  def search
    if params[:category_id].present?
      @events = Event.where(id: Enrollment.where(user_id: @current_user[:id], created: true).pluck(:event_id)).order(id: :desc).where(category_id: params[:category_id])
      render :index
    else
      @events = Event.where(id: Enrollment.where(user_id: @current_user[:id], created: true).pluck(:event_id)).order(id: :desc)
      render :index
    end
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :description, :event_date, :category_id)
  end

  def find_event
    @event = Event.find_by(id: Enrollment.where(user_id: @current_user[:id], event_id: params[:id]).pluck(:event_id))
  end

  def check_user
    if Enrollment.find_by(event_id: @event.id, created: true).user_id != @current_user.id
      flash[:alert] = "You can not edit this event"
      redirect_to @event
    end
  end
end
