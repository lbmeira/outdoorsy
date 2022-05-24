# frozen_string_literal: true

require 'test_helper'

class CustomerDataImportServiceTest < ActiveSupport::TestCase
  test 'Person and vehicle records are generated for a given comma delimeted file' do
    assert_difference 'Person.count', 4 do
      assert_difference 'Vehicle.count', 4 do
        CustomerDataImportService.new('test/fixtures/files/commas.txt', ',').process

        person = Person.find_by(first_name: 'Greta', last_name: 'Thunberg', email: 'greta@future.com')
        vehicle = person.vehicles.first

        assert_equal 1, person.vehicles.count
        assert_equal 'sailboat', vehicle.vehicle_type
        assert_equal 'Fridays For Future', vehicle.name
        assert_equal 32, vehicle.length_value
        assert_equal 'feet', vehicle.length_type
      end
    end
  end

  test 'Person and vehicle records are generated for a given pipe delimeted file' do
    assert_difference 'Person.count', 4 do
      assert_difference 'Vehicle.count', 4 do
        CustomerDataImportService.new('test/fixtures/files/pipes.txt', '|').process

        person = Person.find_by(first_name: 'Ansel', last_name: 'Adams', email: 'a@adams.com')
        vehicle = person.vehicles.first

        assert_equal 1, person.vehicles.count
        assert_equal 'motorboat', vehicle.vehicle_type
        assert_equal 'Rushing Water', vehicle.name
        assert_equal 24, vehicle.length_value
        assert_equal 'feet', vehicle.length_type
      end
    end
  end
end
