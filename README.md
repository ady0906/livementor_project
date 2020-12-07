# JSON to CSV converter LiveMentor Project

This is a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a CSV file where one line equals one object.

## Use the converter as a standalone class

Require the `converter.rb` file with `require_relative 'converter'` (if you are in the same directory).

Instantiate the `Converter` class by passing a url pointing to the JSON file that you want to convert to CSV as a param.

Example:

    converter = Converter.new("https://gist.githubusercontent.com/romsssss/6b8bc16cfd015e2587ef6b4c5ee0f232/raw/f74728a6ac05875dafb882ae1ec1deaae4d0ed4b/users.json")

Access the CSV string by calling the public method:

    csv_string = converter.get_csv_string()

## Run the converter from the command line

Run this command from the directory:

    ruby main.rb [json-url]

Replace `[json-url]` with the link pointing to the JSON file that you want to convert.

## Test the converter

To test the converter, you can run:

	ruby test_converter.rb [json-url] [csv-url]

This command will compare a converted JSON file with a reference CSV string.


Thank you for your consideration !