# frozen_string_literal: true

# notification for experiences
class Notification < ApplicationRecord
  belongs_to :experience

  has_many :guests_notifications, dependent: :destroy
  has_many :guests, through: :guests_notifications,
                    source: :guest

  validates :sms_body, :email_body, presence: true

  def sms_link
    return nil unless sms_body.include? 'http://bit.ly'
    short_link = %r{http:\/\/bit.ly\/.+$}.match(sms_body)[0]
    Bitly.client.expand(short_link).long_url
  end
end
