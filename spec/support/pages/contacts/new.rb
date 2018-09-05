# frozen_string_literal: true

module Pages
  module Contacts
    # page object for contacts/new.html.erb
    class New < SitePrism::Page
      def set_subject_to(subject_text)
        fill_in 'Subject', with: subject_text
      end

      def set_body_to(body_text)
        fill_in 'Body', with: body_text
      end

      def save
        click_on 'Send'
      end
    end
  end
end
