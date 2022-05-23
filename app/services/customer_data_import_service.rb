# frozen_string_literal: true

class CustomerDataImportService
  def initialize(file_path, delimeter)
    @file_path = file_path
    @delimeter = delimeter
  end

  def process
    File.read(file_path).split("\n").each_with_index do |row, index|
      row_elements = row.split(delimeter)
      puts "Processing row # #{index}"

      person = Person.find_or_create_by(first_name: row_elements[0], last_name: row_elements[1], email: row_elements[2])
      Vehicle.find_or_create_by(vehicle_type: row_elements[3], name: row_elements[4], length_value: translate_length_value(row_elements[5]),
                     length_type: translate_length_type(row_elements[5]), person: person)    
    
      puts "First name: #{row_elements[0]}, Last name: #{row_elements[1]}, Email: #{row_elements[2]}," \
           " Vehicle type: #{row_elements[3]}, Vehicle name: #{row_elements[4]}, Vehicle length: #{row_elements[5]}"
    end
  end

  private

  attr_reader :file_path, :delimeter

  def translate_length_type(length_value)
    if length_value.present?
      length_type = length_value.tr("0-9", "")&.strip

      if Vehicle::LENGTH_TYPES.include?(length_type)
        length_type
      else
        Vehicle::LENGTH_TYPE_MAPPING[length_type]
      end
    end
  end

  def translate_length_value(length_value)
    if length_value.present?
      length_value.scan(/\d+/)&.first
    end
  end
end

# initial thought can require 'csv' and parse given col_sep
# files are not csv

# allows service to be utilized by different, sources:
  # external apis, web app page, download to S3, different rake jobs

# note: wrap block in transaction, error handling
# instead of falling entire import, print out list of failed records