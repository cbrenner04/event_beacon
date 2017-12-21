# frozen_string_literal: true

# sub-events of events (i.e. rehearsal dinner)
class Experience < ApplicationRecord
  belongs_to :event

  has_one :notification, dependent: :destroy

  validates :name, :occurs_at, presence: true

  def needs_notifying?
    occurs_at > Time.zone.now - 599 && occurs_at <= Time.zone.now
  end
end
