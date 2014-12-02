require 'rubygems'
require 'csv'
require 'psd'
require 'awesome_print'

require_relative 'csv-to-pdf.rb'

@pdf = @pdf.scan(/\w+/)

#matchy loop
#@pdf = our original str
@csv = CSV.open("trans-test.csv", "r+") do |csv|
	csv.find_all do |row|
		@pdf.each do |i|
			if ( i === row[1] )
	      		row << "success"
	      	end
	    end
    end
end

#output
CSV.open("trans-test_done.csv", "w", force_quotes: true) do |csv|
  csv << @csv[0]
  csv << @csv[1]
  csv << @csv[2]
end

