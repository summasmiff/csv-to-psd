require 'rubygems'
require 'csv'
require 'psd'
require 'awesome_print'

require_relative 'csv-to-psd.rb'

#matchy loop
@csv = CSV.open("trans-test.csv", "r+") do |csv|
	csv.find_all do |row|
    	@h.each do |k, v|
      		row << "success" if( row[1] == @h[k] )
    	end
    end
end

ap @csv

CSV.open("trans-test_done.csv", "w", force_quotes: true) do |csv|
  csv << @csv[0]
  csv << @csv[1]
  csv << @csv[2]
end

#mark CSV with success in third object IF match was found
#how to add third column to each row?

#split data back out of hash into csv
#create arr_of_arrays from csv hash
#split "success" into own index value

#log each array as row
