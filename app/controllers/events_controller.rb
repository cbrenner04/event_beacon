# frozen_string_literal: true

# events controller
class EventsController < ApplicationController
  def index
    @events = current_user.events
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      UsersEvent.create(user: current_user, event: @event)
      redirect_to events_path,
                  notice: "#{@event.nickname} was created successfully."
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path,
                  notice: "#{@event.nickname} was updated successfully."
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event)
          .permit(:name, :occurs_at, :nickname, :organizer,
                  :welcome_sms, :welcome_email)
  end
end
