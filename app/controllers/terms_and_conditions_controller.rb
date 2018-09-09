# frozen_string_literal: true

# simple controller for getting terms and conditions
class TermsAndConditionsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show; end
end
