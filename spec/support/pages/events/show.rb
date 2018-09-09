# frozen_string_literal: true

module Pages
  module Events
    # page object for events/show.html.erb
    class Show < SitePrism::Page
      def navigate_to_guests
        click_on 'Guests'
      end

      def navigate_to_experiences
        click_on 'Experiences'
      end

      def navigate_to_send_all_notification
        click_on 'Send Notification to All Guests Now'
      end
    end
  end
end
