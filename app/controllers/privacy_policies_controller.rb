# frozen_string_literal: true

# simple controller for getting privacy policy
class PrivacyPoliciesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show; end
end
