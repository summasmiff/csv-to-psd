require 'rubygems'
require 'csv'
require 'psd'
require 'awesome_print'

#Problem: Given CSV of English labels in a Photoshop doc with corresponding labels in another language. 
#Find each English phrase as a text-obj in Photoshop, replace text with the other language.
#If successful, mark the CSV in some way
#If unsuccessful, mark CSV in a different way

#csv to dictionary hash
@csv = Hash[ CSV.read('trans-test.csv').map do |row|
	[ row[0].to_s, row[1].to_s ] 
	end 
]

#Test hash
@h = {:Patrick => "monkey", :Chief => "cat", :Polly => "fish", :Smaug => "dragon"}
#Check test hash for matches, and change value using dictionary
@h.each do |k, v|
	@csv.each do |key, value|
		if v == key && value != ""
			@h[k] = value 
		end
	end
end
ap @h


@csv.each do |key, value|
		@csv[key] << ", success" if @csv[key] != "" #mark CSV with successful translations
end
ap @csv
#split data back out of hash into csv
#create arr_of_arrays from csv hash
#split "success" into own index value
@new_csv = @csv.to_a
#log each array as row

CSV.open("trans-test_done.csv", "w", force_quotes: true) do |csv|
  csv << @new_csv[0]
  csv << @new_csv[1]
  csv << @new_csv[2]
end

#Open the PSD
#### PSD gem does not support writing to PSDs ####
PSD.open('trans-test.psd') do |psd|
	@psd = psd.tree.to_hash #Creates nested hash from PSD hierarchy
	ap "The layer's name is #{psd.tree.descendant_layers.first.name}" 
	ap "The layer's text reads #{psd.tree.descendant_layers.first.text[:value]}" 
end







