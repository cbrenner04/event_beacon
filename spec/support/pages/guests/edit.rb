# frozen_string_literal: true

module Pages
  module Guests
    # page object for guests/edit.html.erb
    class Edit < SitePrism::Page
      def set_guest_first_name_to(guest_first_name)
        fill_in 'First name', with: guest_first_name
      end

      def set_guest_last_name_to(guest_last_name)
        fill_in 'Last name', with: guest_last_name
      end

      def save
        click_on 'Save'
      end
    end
  end
end
