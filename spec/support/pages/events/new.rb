# frozen_string_literal: true

module Pages
  module Events
    # page object for events/new.html.erb
    class New < SitePrism::Page
      def set_event_name_to(event_name)
        fill_in 'Name', with: event_name
      end

      def save
        click_on 'Save'
      end
    end
  end
end
