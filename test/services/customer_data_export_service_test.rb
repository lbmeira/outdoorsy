# frozen_string_literal: true

require 'test_helper'

class CustomerDataExportServiceTest < ActiveSupport::TestCase
  setup do
    first_person = Person.create(first_name: 'Peter', last_name: 'Parker', email: 'spidey@example.com')
    Vehicle.create(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, length_type: 'feet', person: first_person)

    second_person = Person.create(first_name: 'John', last_name: 'Smith', email: 'hsmith@example.com')
    Vehicle.create(name: 'Saturday For Future', vehicle_type: 'campervan', length_value: 34, length_type: 'feet', person: second_person)

	  third_person = Person.create(first_name: 'Jane', last_name: 'Doe', email: 'jdoe@example.com')
    Vehicle.create(name: 'Sunday For Future', vehicle_type: 'motorboat', length_value: 35, length_type: 'feet', person: third_person)
  end

  test 'CSV file is generated with the expected data sorted by full name' do
    CustomerDataExportService.new('customer_data_export_service_export_test.csv', 'full_name').process
    actual_csv = File.open('customer_data_export_service_export_test.csv').read
    expected_csv = File.open('test/fixtures/files/expected_customer_data_export_full_name.csv').read
    assert_equal expected_csv, actual_csv
  end

  test 'CSV file is generated with the expected data sorted by vehicle type' do
    CustomerDataExportService.new('customer_data_export_service_export_test.csv', 'vehicle_type').process
    actual_csv = File.open('customer_data_export_service_export_test.csv').read
    expected_csv = File.open('test/fixtures/files/expected_customer_data_export_vehicle_type.csv').read
    assert_equal expected_csv, actual_csv
  end
end

# need to expliclity load services folder in application.rb