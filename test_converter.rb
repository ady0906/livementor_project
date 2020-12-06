require 'net/http'
require_relative 'converter'

json_url = ARGV[0]
csv_url = ARGV[1]

converter = Converter.new(json_url)
csv_string = converter.get_csv_string()

csv_uri = URI(csv_url)
csv_comparison_string = Net::HTTP.get(csv_uri)

if csv_string == csv_comparison_string
	puts 'Test successful: the converted json file and the csv reference are identical'
else
	puts 'Test unsuccessful: the converted json file and the csv reference are different'
end