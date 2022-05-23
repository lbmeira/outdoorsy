# frozen_string_literal: true

require 'csv'

class CustomerDataExportService
  def initialize(file_path, sort_by_value)
    @file_path = file_path
    @sort_by_value = sort_by_value
  end

  def process
    CSV.open(file_path, "w") do |csv|
      customer_data.each do |data|
        puts "Full name: #{data.first_name} #{data.last_name}, Email: #{data.email}, Vehicle type: #{data.vehicle_type}," \
             " Vehicle name: #{data.name}, Vehicle length: #{data.length_value} #{data.length_type}"

        csv << ["#{data.first_name} #{data.last_name}", data.email, data.vehicle_type, data.name, "#{data.length_value} #{data.length_type}"]
      end
    end
  end

  private

  attr_reader :file_path, :sort_by_value

  def customer_data
    select_query = 'first_name, last_name, email, vehicle_type, name, length_value, length_type'

    case sort_by_value
    when 'full_name'
      Person.select(select_query).joins(:vehicles).order(:first_name,:last_name)
    when 'vehicle_type'
      Person.select(select_query).joins(:vehicles).order(:vehicle_type)
    else
      Person.select(select_query).joins(:vehicles)
    end
  end
end
