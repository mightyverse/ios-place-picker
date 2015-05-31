
require 'csv'

# import countries
countries_filename = "countries.tsv"
countries =  CSV.read("./countries.tsv",
                      { col_sep: "\t",
                        headers: true, header_converters: :symbol })

output_file = "./cities.txt"
CSV.open( output_file, 'w' ) do |writer|

  countries = {}
  CSV.foreach("./countries.tsv",
                        { encoding: "UTF-8", col_sep: "\t",
                          headers: true, header_converters: :symbol,
                          }) do |row|
  code = row[:country]
  name = row[:name]
  countries[code] = name
  writer << [name, code, row[:latitude], row[:longitude]]
  end


  # parse cities15000.txt from geonames, header added manually
  input_file = "../cities15000.txt"
  rows = []
  CSV.foreach(input_file,
             { encoding: "UTF-8", col_sep: "\t", quote_char: ";",
               headers: true, header_converters: :symbol
             }) do |row|
    rows << row
    name = row[:name]
    country_code = row[:country]
    country = countries[country_code]
    if country_code == 'BQ' and name == 'Kralendijk'
      country = "Bonaire"
    end

    if country.nil?
      puts "#{name}, #{country_code} -- country code not found"
    else
      name = "#{name}, #{country}"
      writer << [name, country_code, row[:lat], row[:long]]
    end
  end
end
