# frozen_string_literal: true

module Pages
  module Confirmations
    # page object for confirmations/new.html.erb
    class New < SitePrism::Page
      def set_password_to(password)
        fill_in 'Password', with: password
      end

      def set_password_confirmation_to(password_confirmation)
        fill_in 'Password confirmation', with: password_confirmation
      end

      def save
        click_on 'Submit'
      end
    end
  end
end
