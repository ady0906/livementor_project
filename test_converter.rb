require 'net/http'
require_relative 'converter'

json_url = ARGV[0]
csv_url = ARGV[1]

converter = Converter.new(json_url)
csv_string = converter.get_csv_string()

csv_uri = URI(csv_url)
csv_comparison_string = Net::HTTP.get(csv_uri)

puts 'JSON converted to csv:'
puts csv_string
puts '----------------------'
puts 'Comparison csv:'
puts csv_comparison_string
puts '----------------------'

if csv_string == csv_comparison_string
  puts 'Test successful: the converted JSON file and the CSV reference are identical'
else
  puts 'Test unsuccessful: the converted JSON file and the CSV reference are different'
end