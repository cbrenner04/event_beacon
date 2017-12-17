# frozen_string_literal: true

# experiences controller
class ExperiencesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
  end

  def edit
    @experience = Experience.find(params[:id])
  end

  def update
    @experience = Experience.find(params[:id])
    if @experience.update(experience_params)
      redirect_to event_experiences_path(params[:event_id]),
                  notice: "#{@experience.name} was updated successfully."
    else
      render :edit
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:name, :occurs_at)
  end
end
