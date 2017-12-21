# frozen_string_literal: true

namespace :notification do
  desc 'Sends notifications to guests'
  task send: :environment do
    Tasks::Notifier.send_notifications
  end
end
