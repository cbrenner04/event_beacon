# frozen_string_literal: true

module Pages
  module Events
    # page object for events/index.html.erb
    class Index < SitePrism::Page
      def select_event(event_name)
        click_on event_name
      end
    end
  end
end
