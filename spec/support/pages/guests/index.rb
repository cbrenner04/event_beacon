# frozen_string_literal: true

module Pages
  module Guests
    # page object for guests/index.html.erb
    class Index < SitePrism::Page
      element :edit, '.fa-pencil'
      element :delete, '.fa-trash'

      def select_guest(guest_name)
        click_on guest_name
      end
    end
  end
end
