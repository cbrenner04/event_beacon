# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationMailer, type: :mailer do
  let(:host) { 'event-beacon.com' }
  let(:guest_email) { 'sharee.email@example.com' }
  let(:subject) { 'Something is happening soon' }
  let(:message) { 'Please come to the thing. It will be fun.' }

  describe '#email' do
    let(:mail) do
      NotificationMailer.email(
        guest_email: guest_email,
        subject: subject,
        message: message
      )
    end

    it { expect(mail.subject).to eq subject }
    it { expect(mail.to).to eq [guest_email] }
    it { expect(mail.from).to eq ['no-reply@event-beacon.com'] }
    it { expect(mail.body.encoded).to include message }
  end
end
