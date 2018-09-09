# frozen_string_literal: true

# devise User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable, :confirmable

  has_many :users_events, dependent: :destroy
  has_many :events, through: :users_events, source: :event, dependent: :destroy
  has_many :contacts, dependent: :destroy

  validates :email, presence: true

  def password_required?
    super if confirmed?
  end

  # rubocop:disable Metrics/AbcSize
  def password_match?
    errors[:password] << "can't be blank" if password.blank?
    if password_confirmation.blank?
      errors[:password_confirmation] << "can't be blank"
    end
    if password != password_confirmation
      errors[:password_confirmation] << 'does not match password'
    end
    password == password_confirmation && password.present?
  end
  # rubocop:enable Metrics/AbcSize
end
