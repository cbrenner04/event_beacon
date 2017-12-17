# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :feature do
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:event) { create :event }
  let(:other_event) { create :event }

  before do
    create :users_event, user: user, event: event
    create :users_event, user: other_user, event: other_event
    log_in_user user
  end

  describe 'index' do
    it 'displays events related to signed in user' do
      expect(page).to have_link event.name
    end

    it 'links to show page' do
      click_on event.name
      expect(current_path).to eq "/events/#{event.id}"
    end
  end

  describe 'show' do
    before { visit event_path(event) }

    it 'displays links related to event' do
      expect(page).to have_text event.name
    end

    it 'links to event guests' do
      click_on 'Guests'
      expect(current_path).to eq "/events/#{event.id}/guests"
    end

    it 'links to event experiences' do
      click_on 'Experiences'
      expect(current_path).to eq "/events/#{event.id}/experiences"
    end
  end
end
