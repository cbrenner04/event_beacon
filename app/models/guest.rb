# frozen_string_literal: true

# guests of the top-level event
class Guest < ApplicationRecord
  belongs_to :event

  has_many :guests_notifications, dependent: :destroy
  has_many :notifications, through: :guests_notifications,
                           source: :notification

  enum notification_category: %i[text email both]

  validates :first_name, presence: true,
                         if: proc { |guest| guest.last_name.blank? }
  validates :last_name, presence: true,
                        if: proc { |guest| guest.first_name.blank? }
  validates :phone_number, presence: true,
                           if: proc { |guest| guest.email.blank? }
  validates :email, presence: true,
                    if: proc { |guest| guest.phone_number.blank? }

  default_scope { order(last_name: :asc, first_name: :asc) }
  scope :not_related_to_notification,
        ->(notification) { where.not(id: notification.guests.map(&:id)) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def pretty_notification_category
    if notification_category == 'both'
      'text, email'
    else
      notification_category
    end
  end

  def pretty_phone_number
    "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..9]}"
  end
end
