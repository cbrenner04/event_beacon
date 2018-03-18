# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let(:experience) { create :experience, event: event, name: 'asdf' }
  let!(:notification) { create :notification, experience: experience }
  let(:experiences_page) { Pages::Experiences::Index.new }
  let(:new_experience_page) { Pages::Experiences::New.new }
  let(:edit_experience_page) { Pages::Experiences::Edit.new }

  before do
    create :users_event, user: user, event: event
    log_in_user user
  end

  describe 'index' do
    before { visit event_experiences_path(event) }

    it 'lists experiences related to the event' do
      expect(experiences_page).to have_text experience.name
    end

    it 'links to related notification page' do
      experiences_page.select_experience experience.name

      expect(current_path)
        .to eq event_experience_notification_path(event.id, experience.id,
                                                  notification.id)
    end
  end

  describe 'new' do
    before { visit new_event_experience_path(event) }

    it 'allows for adding experience information' do
      new_experience_page.set_experience_name_to 'Foobar in the morning'
      new_experience_page.save

      expect(current_path).to eq event_experiences_path(event.id)
      expect(new_experience_page).to have_text 'Foobar in the morning'
    end

    it 're-renders and gives correct error message if information is bad' do
      new_experience_page.set_experience_name_to ''
      new_experience_page.save

      expect(new_experience_page).to have_text '1 error prohibited this ' \
                                               'experience from being saved:'
      expect(new_experience_page).to have_text "Name can't be blank"
    end
  end

  describe 'edit' do
    before { visit edit_event_experience_path(event, experience) }

    it 'displays experience' do
      expect(edit_experience_page).to have_text experience.name
    end

    it 'allows for updating experience information' do
      edit_experience_page.set_experience_name_to 'Foobar in the morning'
      edit_experience_page.save

      expect(current_path).to eq event_experiences_path(event.id)
      expect(edit_experience_page).to have_text 'Foobar in the morning'
    end

    it 're-renders and gives correct error message if information is bad' do
      edit_experience_page.set_experience_name_to ''
      edit_experience_page.save

      expect(edit_experience_page).to have_text '1 error prohibited this ' \
                                                'experience from being saved:'
      expect(edit_experience_page).to have_text "Name can't be blank"
    end
  end
end
