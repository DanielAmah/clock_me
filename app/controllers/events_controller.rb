class EventsController < ApplicationController
  
  def user_events
    events = if @current_user&.role&.status == 'admin'
      Event.joins(user_profession: :user).where(visible: true).order(created_at: :desc)
    else
      Event.joins(user_profession: :user)&.where(users: {id: @current_user&.id}, visible: true)&.order(created_at: :desc)
    end
    render json: events, each_serializer: EventSerializer
  end

  def index
    if @current_user&.role&.status != 'admin'
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end
    events = Event.joins(user_profession: :user).where(visible: true).order(created_at: :desc)
    render json: events, each_serializer: EventSerializer
  end

  def clock_out
    if current_event.update(clock_out: Time.current)
    
    render json: EventSerializer.new(current_event).as_json
    else
      binding.pry
      render json: {
        errors: current_event.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  def create
    user_profession = UserProfession.find_by(user: @current_user)
    event = Event.new(
        description: event_params[:description],
        clock_in: Time.current,
        user_profession: user_profession
      )

    if event.save
      render json: {data: EventSerializer.new(event).as_json, message: 'New event created!'}
    else 
      render json: {
        errors: event.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user&.role&.status != 'admin'
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end
    current_event.destroy!
    render json: { message: 'Event deleted!'}
  end

  def trash_event
    if @current_user&.role&.status != 'admin'
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end

    if current_event.update(visible: false)
    render json: { message: 'Event sent to trash!'}
    else
      render json: {
        errors: current_event.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  def update
    if current_event.update(event_params)
      render json: {data: EventSerializer.new(current_event).as_json, message: 'Event updated!'}
    else
      render json: {
        errors: current_event.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  private

  def current_event
    @current_event ||= Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:clock_in, :clock_out, :description)
  end
end