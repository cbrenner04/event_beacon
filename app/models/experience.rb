class Experience < ApplicationRecord
  belongs_to :event

  has_one :notification

  validates :name, :occurs_at, presence: true
end
