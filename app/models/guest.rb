# frozen_string_literal: true

# guests of the top-level event
class Guest < ApplicationRecord
  belongs_to :event

  has_many :guests_notifications, dependent: :destroy
  has_many :notifications, through: :guests_notifications,
                           source: :notification,
                           dependent: :destroy

  enum notification_category: %i[text email both]

  validates :first_name, presence: true,
                         if: proc { |guest| guest.last_name.blank? }
  validates :last_name, presence: true,
                        if: proc { |guest| guest.first_name.blank? }
  validates :phone_number, presence: true,
                           if: proc { |guest| guest.email.blank? }
  validates :email, presence: true,
                    if: proc { |guest| guest.phone_number.blank? }

  def full_name
    "#{first_name} #{last_name}"
  end
end
