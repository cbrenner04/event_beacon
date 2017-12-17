# frozen_string_literal: true

# devise User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable

  has_many :users_events, dependent: :destroy
  has_many :events, through: :users_events, source: :event, dependent: :destroy

  validates :email, presence: true
end
