# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:experience) { create :experience, event: event }
  let!(:notification) { create :notification, experience: experience }

  before do
    create :users_event, user: user, event: event
    log_in_user user
  end

  describe 'index' do
    before { visit event_experiences_path(event) }

    it 'lists experiences related to the event' do
      expect(page).to have_text experience.name
    end

    it 'links to experience edit page' do
      find('tr', text: experience.name).find('.fa-pencil').click
      expect(current_path)
        .to eq "/events/#{event.id}/experiences/#{experience.id}/edit"
    end

    it 'links to related notification page' do
      within('tr', text: experience.name) { click_on 'Notification' }
      expect(current_path).to eq "/events/#{event.id}/experiences/" \
                                 "#{experience.id}/notifications/" \
                                 "#{notification.id}"
    end
  end

  describe 'edit' do
    before { visit edit_event_experience_path(event, experience) }

    it 'displays experience' do
      expect(page).to have_text experience.name
    end

    it 'allows for updating experience information' do
      fill_in 'Name', with: 'Foobar in the morning'
      click_on 'Save'
      expect(current_path).to eq "/events/#{event.id}/experiences"
      expect(page).to have_text 'Foobar in the morning'
    end

    it 're-renders and gives correct error message if information is bad' do
      fill_in 'Name', with: ''
      click_on 'Save'
      expect(page).to have_text '1 error prohibited this experience from ' \
                                'being saved:'
      expect(page).to have_text "Name can't be blank"
    end
  end
end
