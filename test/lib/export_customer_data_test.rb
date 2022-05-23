# frozen_string_literal: true

require 'test_helper'
require 'rake'

class ExportCustomerDataTest < ActiveSupport::TestCase
  setup do
    Outdoorsy::Application.load_tasks
  end

  teardown do
    Rake::Task.clear
  end

  setup do
    first_person = Person.create(first_name: 'Peter', last_name: 'Parker', email: 'spidey@example.com')
    Vehicle.create(name: 'Fridays For Future', vehicle_type: 'sailboat', length_value: 32, length_type: 'feet', person: first_person)

    second_person = Person.create(first_name: 'John', last_name: 'Smith', email: 'hsmith@example.com')
    Vehicle.create(name: 'Saturday For Future', vehicle_type: 'campervan', length_value: 34, length_type: 'feet', person: second_person)

    third_person = Person.create(first_name: 'Jane', last_name: 'Doe', email: 'jdoe@example.com')
    Vehicle.create(name: 'Sunday For Future', vehicle_type: 'motorboat', length_value: 35, length_type: 'feet', person: third_person)
  end

  test 'successfully exports customer data sorted by full name' do
    freeze_time do
      Rake::Task['export_customer_data'].invoke('full_name')
      actual_csv = File.open("customer_data_export_#{Time.now.strftime('%Y%m%d%k%M%S')}.csv").read
      expected_csv = File.open('test/fixtures/files/expected_customer_data_export_full_name.csv').read
      assert_equal expected_csv, actual_csv
    end
  end

  test 'successfully exports customer data sorted by vehicle type' do
    freeze_time do
      Rake::Task['export_customer_data'].invoke('vehicle_type')
      actual_csv = File.open("customer_data_export_#{Time.now.strftime('%Y%m%d%k%M%S')}.csv").read
      expected_csv = File.open('test/fixtures/files/expected_customer_data_export_vehicle_type.csv').read
      assert_equal expected_csv, actual_csv
    end
  end

  test 'fails to export customer data if sort by value is missing' do
    assert_raises('Missing parameter :sort_by_value') do
      Rake::Task['export_customer_data'].invoke()
    end
  end

  test 'fails to export customer data if the sort by value argument is invalid' do
    assert_raises("Data can only be sorted by 'full_name' or a 'vehicle_type'. Invalid sort_by_value input: 'email'") do
      Rake::Task['export_customer_data'].invoke('email')
    end
  end
end
