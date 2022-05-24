# frozen_string_literal: true

class Person < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  has_many :vehicles

  def full_name
    "#{first_name} #{last_name}"
  end
end
