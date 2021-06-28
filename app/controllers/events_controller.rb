class EventsController < ApplicationController
  
  def user_events
    events_relation = Event.joins(user_profession: :user)
    
    events = if user_policy.admin?
      event_query.all_events_in_desc(events_relation)
    else
      event_query.current_user_events_in_desc(events_relation, @current_user)
    end

    render json: events, each_serializer: EventSerializer
  end

  def index
    if user_policy.staff?
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end
    events_relation = Event.joins(user_profession: :user)

    events = event_query.all_events_in_desc(events_relation)
    render json: events, each_serializer: EventSerializer
  end

  def clock_out
    if current_event.update(clock_out: Time.current)
    
    render json: EventSerializer.new(current_event).as_json
    else
      render json: {
        errors: current_event.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  def create
    @form = EventForm.new(@current_user, event_params)
    
    if @form.save
      render json: {data: EventSerializer.new(@form.record).as_json, message: 'New event created!'}
    else 
      render json: {
        errors: @form.errors.full_messages.join(", ")
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if user_policy.staff?
      raise ExceptionHandler::Forbidden, "Need admin privileges!"
    end
    current_event.destroy!
    render json: { message: 'Event deleted!'}
  end

  def trash_event
    if user_policy.staff?
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

  def user_policy
    UsersPolicy.new(@current_user)
  end

  def current_event
    @current_event ||= Event.find(params[:id])
  end
  
  def event_query
    EventQuery.new()
  end

  def event_params
    params.require(:event).permit(:clock_in, :clock_out, :description)
  end
end