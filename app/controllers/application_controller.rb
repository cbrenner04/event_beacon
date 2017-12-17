# frozen_string_literal: true

# top level controller
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_timezone

  def set_timezone
    Time.zone = 'Central Time (US & Canada)'
  end
end
