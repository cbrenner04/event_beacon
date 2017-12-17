# frozen_string_literal: true

# guests controller
class GuestsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @guests = @event.guests
  end

  def edit
    @guest = Guest.find(params[:id])
  end

  def update
    @guest = Guest.find(params[:id])
    if @guest.update(guest_params)
      redirect_to event_guests_path(params[:event_id]),
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
end
