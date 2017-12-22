# frozen_string_literal: true

# experiences controller
class ExperiencesController < ApplicationController
  def index
    set_event
  end

  def new
    set_event
    @experience = Experience.new
  end

  def create
    set_event
    @experience = @event.experiences.build(experience_params)
    if @experience.save
      create_notification
      redirect_to event_experiences_path(@event), notice: create_notice_message
    else
      render :new
    end
  end

  def edit
    set_event
    @experience = Experience.find(params[:id])
  end

  def update
    set_event
    @experience = Experience.find(params[:id])
    if @experience.update(experience_params)
      redirect_to event_experiences_path(@event),
                  notice: "#{@experience.name} was updated successfully."
    else
      render :edit
    end
  end

  private

  def experience_params
    params.require(:experience).permit(:name, :occurs_at, :notification_offset)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def default_sms_body
    "#{experience_params[:name]} starts at #{occurs_at_time}"
  end

  def default_email_body
    "Hello, #{experience_params[:name]} starts at #{occurs_at_time}. Thanks!"
  end

  def occurs_at_time
    "#{experience_params['occurs_at(4i)']}:" \
    "#{experience_params['occurs_at(5i)']}"
  end

  def create_notification
    @experience.create_notification(
      sms_body: default_sms_body,
      email_body: default_email_body
    )
  end

  def create_notice_message
    "#{@experience.name} was saved successfully. Make " \
    'sure to update the Notification with what you ' \
    'want it to say and who you want it to be sent to.'
  end
end
