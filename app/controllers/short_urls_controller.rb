# frozen_string_literal: true

# simple controller for getting shortened urls
class ShortUrlsController < ApplicationController
  def show
    short_link = Bitly.client.shorten(params[:link]).short_url
    render plain: helpers.sanitize(short_link)
  end
end
