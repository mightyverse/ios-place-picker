# parse cities5000.txt from geonames

require 'csv'
input_file = "../cities5000.txt"
output_file = "./cities.txt"
CSV.open( output_file, 'w' ) do |writer|
puts "here"
  CSV.foreach(input_file, { encoding: "UTF-8", headers: true, header_converters: :symbol, :col_sep => "\t", :quote_char => ";"}) do |row|
    writer << [row[:name], row[:lat], row[:long]]
  end
end
