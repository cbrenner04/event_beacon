class Event < ApplicationRecord
  has_many :experiences
  has_many :guests
  has_many :users_events, dependent: :destroy
  has_many :users, through: :users_events, source: :user, dependent: :destroy

  validates :name, :occurs_at, presence: true
end
