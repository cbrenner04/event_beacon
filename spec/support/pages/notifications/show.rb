# frozen_string_literal: true

module Pages
  module Notifications
    # page object for notifications/show.html.erb
    class Show < SitePrism::Page
      element :edit, '.fa-pencil'
      element :delete, '.fa-trash'

      def navigate_to_edit
        click_on 'Edit'
      end

      def select_guest(guest_name)
        click_on guest_name
      end
    end
  end
end
