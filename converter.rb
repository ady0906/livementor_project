require 'csv'
require 'json'
require 'net/http'

class Converter

	def initialize(json_url)
		@json_url = json_url
		@headers = Array.new
		@csv_string = convert_json_to_csv()
	end

	def get_csv_string()
		puts @csv_string
		return @csv_string
	end

	private
	def convert_json_to_csv()
		final = Array.new
		uri = URI(@json_url)
		json_response = JSON.parse(Net::HTTP.get(uri))
		json_response.each_with_index do |row, index|
			if index == 0
				final.append(make_headers(row))
				final.append(make_rows(@headers, row))
			else
				final.append(make_rows(@headers, row))
			end
		end

		csv_string = CSV.generate do |csv|
			final.each do |row|
				csv << row
			end
		end

		return csv_string
	end

	# Defining headers
	private
	def make_headers(row)
		row.keys.each do |column|
			build_header_recursively(column, row[column])
		end
		return @headers
	end

	# Using recursion to get to headers inside nested objects
	private
	def build_header_recursively(column, value)
		if value.class == Hash
			value.each do |key, element|
				new_column = column + '.' + key
				build_header_recursively(new_column, element)
			end
		else
			@headers.append(column)
		end
	end

	# With headers already defined, we can access column values to define rows
	private
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

end