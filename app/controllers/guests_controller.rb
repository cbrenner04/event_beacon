# frozen_string_literal: true

# guests controller
class GuestsController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def edit
    @guest = Guest.find(params[:id])
  end
end
