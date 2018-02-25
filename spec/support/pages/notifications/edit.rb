# frozen_string_literal: true

module Pages
  module Notifications
    # page object for notifications/edit.html.erb
    class Edit < SitePrism::Page
      element :sms_body, '#notification_sms_body'
      element :email_preview, '#email-body-preview'

      def set_sms_body_to(sms_body)
        fill_in 'SMS body', with: sms_body
      end

      def set_email_body_to(email_body)
        fill_in 'Email body', with: email_body
      end

      def set_sms_link_to(sms_link)
        fill_in 'SMS Link', with: sms_link
      end

      def append_sms_link
        click_on 'Append link to SMS body'
      end

      def save
        click_on 'Save'
      end

      def mock_key_up
        execute_script("$('#notification_email_body').keyup()")
      end
    end
  end
end
