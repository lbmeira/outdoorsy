# frozen_string_literal: true

require 'test_helper'
require 'rake'

class ImportCustomerDataTest < ActiveSupport::TestCase
  setup do
    Outdoorsy::Application.load_tasks
  end

  teardown do
    Rake::Task.clear
  end

  test 'successfully import customer data if all valid options are passed' do
    assert_difference 'Person.count', 4 do
      assert_difference 'Vehicle.count', 4 do
        Rake::Task['import_customer_data'].invoke('test/fixtures/files/commas.txt',',')

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

  test 'fails to import customer data if file_path argument is missing' do
    assert_raises('Missing parameter :file_path') do
      Rake::Task['import_customer_data'].invoke()
    end
  end

  test 'fails to import customer data if delimeter argument is missing' do
    assert_raises('Missing parameter :delimeter') do
      Rake::Task['import_customer_data'].invoke('test/fixtures/files/commas.txt')
    end
  end

  test 'fails to import customer data if specified file_path does not exist' do
    assert_raises('File file_does_not_exist.txt does not exist') do
      Rake::Task['import_customer_data'].invoke('file_does_not_exist.txt', '|')
    end
  end

  test 'fails to import customer data if the delimeter argument is invalid' do
    assert_raises("Delimeter must be a '|' or a ','. Invalid delimeter input: -") do
      Rake::Task['import_customer_data'].invoke('file_does_not_exist.txt', '|')
    end
  end
end
