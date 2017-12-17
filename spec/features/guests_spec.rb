# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Experiences', type: :feature do
  let(:user) { create :user }
  let(:event) { create :event }
  let!(:guest) { create :guest, event: event }

  before do
    create :users_event, user: user, event: event
    log_in_user user
  end

  describe 'index' do
    before { visit event_guests_path(event) }

    it 'lists guests related to the event' do
      expect(page).to have_text guest.first_name
    end

    it 'links to guest edit page' do
      find('tr', text: guest.first_name).find('.fa-pencil').click
      expect(current_path)
        .to eq "/events/#{event.id}/guests/#{guest.id}/edit"
    end
  end

  describe 'edit' do
    before { visit edit_event_guest_path(event, guest) }

    it 'displays guest' do
      expect(page).to have_text guest.first_name
    end
  end
end
