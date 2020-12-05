require 'csv'
require 'json'
require 'net/http'

def recursive_search(value)
	puts value
	if value.class == Integer || value.class == String
		return value
	end
end

def make_headers(row)
	final = Array.new
	row.keys.each do |column|
		final.append(recursive_search(row[column.to_s]))
	end
	puts final
end

ARGV.each do|url|
	uri = URI(url)
	json_response = JSON.parse(Net::HTTP.get(uri))
	json_response.each_with_index do |row, index|
		if index == 0
			make_headers(row)
		end
	end
end