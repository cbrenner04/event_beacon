# frozen_string_literal: true

# top-level event (i.e. wedding)
class Event < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :guests, dependent: :destroy
  has_many :users_events, dependent: :destroy
  has_many :users, through: :users_events, source: :user, dependent: :destroy

  validates :name, :occurs_at, presence: true
end
