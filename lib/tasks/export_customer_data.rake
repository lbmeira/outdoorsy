# frozen_string_literal: true

desc 'Exports customer data to a new file in a specified order'
task :export_customer_data, %i[sort_by_value] => :environment do |_, args|
  sort_by_value = args[:sort_by_value]

  raise "Missing parameter :sort_by_value" unless sort_by_value
  unless %(full_name vehicle_type).include?(sort_by_value)
    raise "Data can only be sorted by 'full_name' or a 'vehicle_type'. Invalid sort_by_value input: '#{sort_by_value}'"
  end

  file_path = "customer_data_export_#{Time.now.strftime("%Y%m%d%k%M%S")}.csv"

  puts "Exporting customer data to: #{file_path}"
  CustomerDataExportService.new(file_path, sort_by_value).process
  puts 'Done!'
end
