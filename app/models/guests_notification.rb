# frozen_string_literal: true

# guest / notification join table
class GuestsNotification < ApplicationRecord
  belongs_to :guest
  belongs_to :notification

  validates :guest, :notification, presence: true
  validates :guest, uniqueness: { scope: :notification }

  default_scope { includes(:guest).order('guests.last_name asc') }
end
