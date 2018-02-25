# frozen_string_literal: true

module Pages
  module Experiences
    # page object for experiences/new.html.erb
    class New < SitePrism::Page
      def set_experience_name_to(experience_name)
        fill_in 'Name', with: experience_name
      end

      def save
        click_on 'Save'
      end
    end
  end
end
