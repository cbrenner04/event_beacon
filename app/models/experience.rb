# frozen_string_literal: true

# sub-events of events (i.e. rehearsal dinner)
class Experience < ApplicationRecord
  belongs_to :event

  has_one :notification, dependent: :destroy

  validates :name, :occurs_at, :notification_offset, presence: true

  default_scope { order(occurs_at: :asc) }

  def needs_notifying?
    ten_minutes_less_one_second_ago = Time.zone.now - 599
    time_to_send_notification > ten_minutes_less_one_second_ago &&
      time_to_send_notification <= Time.zone.now
  end

  def time_to_send_notification
    occurs_at - offset_in_seconds
  end

  def pretty_occurs_at
    occurs_at.strftime('%-m/%-d/%y %l:%M %P')
  end

  private

  def offset_in_seconds
    notification_offset * 60
  end
end
