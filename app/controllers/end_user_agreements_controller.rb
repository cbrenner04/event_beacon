# frozen_string_literal: true

# simple controller for getting end-user agreement
class EndUserAgreementsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show; end
end
