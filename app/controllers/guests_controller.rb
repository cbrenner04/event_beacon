# frozen_string_literal: true

# guests controller
class GuestsController < ApplicationController
  def index
    set_event
    @guests = @event.guests
  end

  def new
    set_event
    @guest = Guest.new
  end

  def create
    set_event
    @guest = @event.guests.build(guest_params)
    if @guest.save
      redirect_to event_guests_path(@event),
                  notice: "#{@guest.full_name} was saved successfully."
    else
      render :new
    end
  end

  def edit
    set_event
    @guest = Guest.find(params[:id])
  end

  def update
    set_event
    @guest = Guest.find(params[:id])
    if @guest.update(guest_params)
      redirect_to event_guests_path(@event),
                  notice: "#{@guest.full_name} was updated successfully."
    else
      render :edit
    end
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :email,
                                  :phone_number, :notification_category)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end
