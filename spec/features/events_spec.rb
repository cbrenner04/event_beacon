# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :feature do
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:event) { create :event }
  let(:other_event) { create :event }
  let(:events_page) { Pages::Events::Index.new }
  let(:event_page) { Pages::Events::Show.new }
  let(:new_event_page) { Pages::Events::New.new }
  let(:edit_event_page) { Pages::Events::Edit.new }

  before do
    create :users_event, user: user, event: event
    create :users_event, user: other_user, event: other_event
    log_in_user user
  end

  describe 'index' do
    it 'displays events related to signed in user' do
      expect(events_page).to have_link event.name
    end

    it 'links to show page' do
      events_page.select_event event.name
      expect(current_path).to eq event_path(event.id)
    end
  end

  describe 'show' do
    before { visit event_path(event) }

    it 'displays links related to event' do
      expect(event_page).to have_text event.name
    end

    it 'links to event guests' do
      events_page.navigate_to_guests

      expect(current_path).to eq event_guests_path(event.id)
    end

    it 'links to event experiences' do
      events_page.navigate_to_experiences

      expect(current_path).to eq event_experiences_path(event.id)
    end
  end

  describe 'new' do
    before { visit new_event_path }

    it 'allows for adding event information' do
      new_event_page.set_event_name_to 'Foobar in the morning'
      new_event_page.save

      expect(current_path).to eq events_path
      expect(new_event_page).to have_text 'Foobar in the morning'
    end

    it 're-renders and gives correct error message if information is bad' do
      new_event_page.set_event_name_to ''
      new_event_page.save

      expect(new_event_page).to have_text '1 error prohibited this event ' \
                                          'from being saved:'
      expect(new_event_page).to have_text "Name can't be blank"
    end
  end

  describe 'edit' do
    before { visit edit_event_path(event) }

    it 'displays event' do
      expect(page).to have_text event.name
    end

    it 'allows for updating event information' do
      edit_event_page.set_event_name_to 'Foobar in the morning'
      edit_event_page.save

      expect(current_path).to eq events_path
      expect(edit_event_page).to have_text 'Foobar in the morning'
    end

    it 're-renders and gives correct error message if information is bad' do
      edit_event_page.set_event_name_to ''
      edit_event_page.save

      expect(edit_event_page).to have_text '1 error prohibited this event ' \
                                           'from being saved:'
      expect(edit_event_page).to have_text "Name can't be blank"
    end
  end
end
