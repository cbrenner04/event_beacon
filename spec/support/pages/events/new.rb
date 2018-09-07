# frozen_string_literal: true

module Pages
  module Events
    # page object for events/new.html.erb
    class New < SitePrism::Page
      def set_event_name_to(event_name)
        fill_in 'Name', with: event_name
      end

      def set_nickname_to(nickname)
        fill_in 'Nickname', with: nickname
      end

      def set_organizer_to(organizer)
        fill_in 'Organizer', with: organizer
      end

      def save
        click_on 'Save'
      end
    end
  end
end
