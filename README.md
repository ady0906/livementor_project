# JSON to CSV converter LiveMentor Project

This is a small Ruby lib aiming to convert JSON files composed of arrays of objects (all following the same schema) to a CSV file where one line equals one object.

## Run the converter

Run this command from the directory

    ruby main.rb [json-url]

Replace `[json-url]` with the link pointing to the json file that you want to convert.


## Test the converter

To test the converter, you can run 

	ruby test_converter.rb [json-url] [csv-url]

This command will compare the converted json file with a reference csv string

Thank you for your consideration !