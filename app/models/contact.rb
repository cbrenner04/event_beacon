# frozen_string_literal: true

# model for contact us records
class Contact < ApplicationRecord
  belongs_to :user

  validates :subject, :body, presence: true
end
