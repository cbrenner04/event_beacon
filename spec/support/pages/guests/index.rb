# frozen_string_literal: true

module Pages
  module Guests
    # page object for guests/index.html.erb
    class Index < SitePrism::Page
      element :edit, '.fa-pencil'
      element :delete, '.fa.fa-lg.fa-trash'

      def select_guest(guest_name)
        click_on guest_name
      rescue Capybara::Poltergeist::MouseEventFailed
        find('button', text: guest_name).trigger('click')
      end

      def wait_for_accordion_to_open
        # TODO: sort out a better solution
        sleep 1
      end
    end
  end
end
