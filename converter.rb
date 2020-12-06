require 'csv'
require 'json'
require 'net/http'

class Converter

	def initialize(json_url)
		@json_url = json_url
		@headers = Array.new
		@final = Array.new
	end

	def get_csv_string()
		uri = URI(@json_url)
		json_response = JSON.parse(Net::HTTP.get(uri))
		json_response.each_with_index do |row, index|
			if index == 0
				@final.append(make_headers(row))
				@final.append(make_rows(@headers, row))
			else
				@final.append(make_rows(@headers, row))
			end
		end

		csv_string = CSV.generate do |csv|
			@final.each do |row|
				csv << row
			end
		end

		puts csv_string
		return csv_string
	end

	private
	def make_headers(row)
		row.keys.each do |column|
			build_header_recursively(column, row[column])
		end
		return @headers
	end

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