require_relative 'converter'

json_url = ARGV[0]
converter = Converter.new(json_url)
csv_string = converter.get_csv_string()