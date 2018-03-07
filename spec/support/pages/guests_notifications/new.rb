# frozen_string_literal: true

module Pages
  module GuestsNotifications
    # page object for guests_notifications/new.html.erb
    class New < SitePrism::Page
      def select_guest(guest_name)
        check guest_name
      end

      def save
        click_on 'Save'
      end

      def select_add_guests_link
        click_on add_guests_link_text
      end

      def add_guests_helper_text(experience)
        "Please #{add_guests_link_text} before " \
        "adding them to \"#{experience.name}\""
      end

      def add_guests_link_text
        'add Guests to this Event'
      end
    end
  end
end
