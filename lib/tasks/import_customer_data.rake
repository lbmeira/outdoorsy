# frozen_string_literal: true

desc 'Imports customer data from a given file with a specified delimeter'
task :import_customer_data, %i[file_path delimeter] => :environment do |_, args|
  %i[file_path delimeter].each do |key|
    raise "Missing parameter :#{key}" unless args[key]
  end

  file_path = args[:file_path]
  delimeter = args[:delimeter]

  raise "File #{file_path} does not exist" unless File.exist?(file_path)
  raise "Delimeter must be a '|' or a ','. Invalid delimeter input: '#{delimeter}'" unless %(, |).include?(delimeter)

  puts "Importing customer data from: #{file_path}"
  CustomerDataImportService.new(file_path, delimeter).process
  puts 'Done!'
end
