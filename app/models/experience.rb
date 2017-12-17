# frozen_string_literal: true

# sub-events of events (i.e. rehearsal dinner)
class Experience < ApplicationRecord
  belongs_to :event

  has_one :notification

  validates :name, :occurs_at, presence: true
end
