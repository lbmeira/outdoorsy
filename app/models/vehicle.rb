# frozen_string_literal: true

class Vehicle < ApplicationRecord
	LENGTH_TYPES = %w(feet meters)
  LENGTH_TYPE_MAPPING = {
    "’" => 'feet',
    'ft' => 'feet'
  }

  validates :name, presence: true
  validates :vehicle_type, presence: true
  validates :length_value, presence: true
  validates :length_type, presence: true, inclusion: LENGTH_TYPES

  belongs_to :person
end
