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
    end
  end
end
