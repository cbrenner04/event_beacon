# frozen_string_literal: true

module Pages
  module Notifications
    # page object for notifications/show.html.erb
    class Show < SitePrism::Page
      element :edit, '.fa-pencil'
      element :delete, '.fa-trash'

      def navigate_to_edit_experience_timing
        click_on 'Edit notification timing'
      end

      def navigate_to_edit_notification_body
        click_on 'Edit notification body'
      end

      def select_guest(guest_name)
        click_on guest_name
      end

      def wait_for_accordion_to_open
        # TODO: sort out a better solution
        sleep 1
      end
    end
  end
end
