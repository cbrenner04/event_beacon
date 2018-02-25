# frozen_string_literal: true

module Pages
  module Events
    # page object for events/index.html.erb
    class Index < SitePrism::Page
      def select_event(event_name)
        click_on event_name
      end

      def navigate_to_guests
        click_on 'Guests'
      end

      def navigate_to_experiences
        click_on 'Experiences'
      end
    end
  end
end
