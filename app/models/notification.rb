class Notification < ApplicationRecord
  belongs_to :experience

  has_many :guests_notifications, dependent: :destroy
  has_many :guests, through: :guests_notifications,
                    source: :guest,
                    dependent: :destroy

  validates :sms_body, :email_body, presence: true
end
