# frozen_string_literal: true

module Pages
  module Experiences
    # page object for experiences/index.html.erb
    class Index < SitePrism::Page
      element :edit, '.fa-pencil'

      def select_experience(experience_name)
        click_on experience_name
      end

      def navigate_to_notification
        click_on 'Notification'
      end
    end
  end
end
