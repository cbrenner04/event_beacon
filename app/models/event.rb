# frozen_string_literal: true

# top-level event (i.e. wedding)
class Event < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :users_events, dependent: :destroy
  has_many :users, through: :users_events, source: :user, dependent: :destroy

  validates :name, :occurs_at, :organizer, presence: true

  default_scope { order(occurs_at: :asc) }

  before_save :use_name_as_nickname
  after_save :update_welcome_email
  after_save :update_welcome_sms

  private

  def use_name_as_nickname
    return if nickname.present?
    self.nickname = name
    save
  end

  def update_welcome_email
    return if welcome_email.present?
    self.welcome_email =
      "Hello,\n\n#{organizer} has signed you up for notifications for #{name}."
    save
  end

  def update_welcome_sms
    return if welcome_sms.present?
    self.welcome_sms =
      "#{organizer} has signed you up for notifications for #{name}."
    save
  end
end
