# frozen_string_literal: true

# model for contact us records
class Contact < ApplicationRecord
  belongs_to :user, optional: true

  validates :subject, :body, presence: true
end
