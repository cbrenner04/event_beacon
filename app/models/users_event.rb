class UsersEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user, :event, presence: true
  validates :user, uniqueness: { scope: :event }
end
