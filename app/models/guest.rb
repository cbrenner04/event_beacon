# frozen_string_literal: true

# guests of the top-level event
class Guest < ApplicationRecord
  belongs_to :event
  belongs_to :email_encrypted_field,
             class_name: 'EncryptedField',
             foreign_key: 'email_encrypted_field_id',
             inverse_of: :guests
  belongs_to :phone_number_encrypted_field,
             class_name: 'EncryptedField',
             foreign_key: 'phone_number_encrypted_field_id',
             inverse_of: :guests

  has_many :guests_notifications, dependent: :destroy
  has_many :notifications, through: :guests_notifications,
                           source: :notification

  enum notification_category: %i[text email both]

  validates :first_name,
            presence: true,
            if: proc { |guest| guest.last_name.blank? }
  validates :last_name,
            presence: true,
            if: proc { |guest| guest.first_name.blank? }
  validate :email_validator
  validate :phone_number_validator

  default_scope { order(last_name: :asc, first_name: :asc) }
  scope :not_related_to_notification,
        ->(notification) { where.not(id: notification.guests.map(&:id)) }

  after_create :send_welcome_notifications
  before_update :send_welcome_notifications, if: :needs_welcome?

  def email=(val)
    return unless val
    email_encrypted_field.blob = val
  end

  def email
    email_encrypted_field.blob
  end

  def email_encrypted_field
    super || build_email_encrypted_field
  end

  def phone_number=(val)
    value = val.blank? ? '' : val.gsub(/[^0-9]/, '')
    phone_number_encrypted_field.blob = value
  end

  def phone_number
    phone_number_encrypted_field.blob
  end

  def phone_number_encrypted_field
    super || build_phone_number_encrypted_field
  end

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
    return unless phone_number
    "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..9]}"
  end

  private

  def email_validator
    emails = Guest.where.not(id: id).where(event_id: event_id).map(&:email)
    return unless emails.include?(email)
    errors.add(
      :email,
      '- It looks like the guest shares an email with another guest. ' \
      'If this is the case, please leave email blank.'
    )
  end

  def phone_number_validator
    phone_numbers =
      Guest.where.not(id: id).where(event_id: event_id).map(&:phone_number)
    return unless phone_numbers.include?(phone_number)
    errors.add(
      :phone_number,
      '- It looks like the guest shares a phone number with another guest.' \
      ' If this is the case, please leave phone number blank.'
    )
  end

  def send_welcome_notifications
    Tasks::Notifier.send_first_notification(self)
  end

  def needs_welcome?
    return false unless notification_category_changed?
    return true if %w[text both].include?(notification_category) &&
                   welcome_sms_sent_at.nil?
    return true if %w[email both].include?(notification_category) &&
                   welcome_email_sent_at.nil?
  end
end
