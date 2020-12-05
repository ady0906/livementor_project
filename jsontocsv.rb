require 'csv'
require 'json'
require 'net/http'

$final = Array.new
$headers = Array.new

def recursive_search(column, value)
	if value.class == Hash
		value.each do |key, element|
			new_column = column + '.' + key
			recursive_search(new_column, element)
		end
	else
		$headers.append(column)
	end
end

def make_headers(row)
	row.keys.each do |column|
		recursive_search(column, row[column])
	end
	return $headers
end

def make_rows(headers, row)
	values = Array.new
	headers.each do |header|
		value = header.split('.').inject(row,:[])
		if value.class == Array
			values.append(value.join(','))
		else
			values.append(value)
		end
	end
	return values
end

ARGV.each do|url|
	uri = URI(url)
	json_response = JSON.parse(Net::HTTP.get(uri))
	json_response.each_with_index do |row, index|
		if index == 0
			$final.append(make_headers(row))
			$final.append(make_rows($headers, row))
		else
			$final.append(make_rows($headers, row))
		end
	end
	csv_string = CSV.generate do |csv|
		$final.each do |row|
			csv << row
		end
	end
	puts csv_string 
end