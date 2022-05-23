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

# rails g model person, creates migration, model, unit test
# potential enhancements: email validation
# If I had more time I would update rubocop rules


# pulled person information into its table for better data normilzation (solve data redundancy

# replace primary ids with uuid