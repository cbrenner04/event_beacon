# frozen_string_literal: true

# experiences controller
class ExperiencesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def edit
    @experience = Experience.find(params[:id])
  end
end
