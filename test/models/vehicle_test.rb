require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  setup do
    @person = Person.create(first_name: 'Peter', last_name: 'Parker', email: 'spidey@example.com')
  end

	test 'valid vehicle' do
    vehicle = Vehicle.new(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, length_type: 'feet', person: @person)
    assert vehicle.valid?
  end

  test 'vehicle record is invalid without name' do
    vehicle = Vehicle.new(vehicle_type: 'sailboat', length_value: 32, length_type: 'feet', person: @person)
    refute vehicle.valid?
    assert_equal ["can't be blank"], vehicle.errors[:name]
  end

  test 'vehicle record is invalid without vehicle_type' do
    vehicle = Vehicle.new(name: 'Fridays For Future', length_value: 32, length_type: 'feet', person: @person)
    refute vehicle.valid?
    assert_equal ["can't be blank"], vehicle.errors[:vehicle_type]
  end

  test 'vehicle record is invalid without length_value' do
    vehicle = Vehicle.new(name: 'Fridays For Future', vehicle_type: 'sailboat', length_type: 'feet', person: @person)
    refute vehicle.valid?
    assert_equal ["can't be blank"], vehicle.errors[:length_value]
  end

  test 'vehicle record is invalid without length_type' do
    vehicle = Vehicle.new(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, person: @person)
    refute vehicle.valid?
    assert_equal ["can't be blank", 'is not included in the list'], vehicle.errors[:length_type]
  end

  test 'vehicle record is invalid with a length_type that is not expected' do
    vehicle = Vehicle.new(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, length_type: 'inches', person: @person)
    refute vehicle.valid?
    assert_equal ['is not included in the list'], vehicle.errors[:length_type]
  end

  test 'vehicle record is invalid without person_id' do
    vehicle = Vehicle.new(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, length_type: 'feet')
    refute vehicle.valid?
    assert_equal ['must exist'], vehicle.errors[:person]
  end
end
