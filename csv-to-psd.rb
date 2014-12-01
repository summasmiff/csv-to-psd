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
	[ row[0].to_s, (row[1].to_s unless row[1] == nil) ] 
	end 
]

ap @csv
#Test hash => replace with PSD hash
@h = {:Patrick => "monkey", :Chief => "cat", :Polly => "fish", :Smaug => "dragon"}

#Check test hash for matches, and change value using dictionary
@h.each do |k, v|
	@csv.each do |key, value|
		if v == key && value != nil
			@h[k] = value 
		end
	end
end

ap @h

#Open the PSD
#### PSD gem does not support writing to PSDs ####
PSD.open('trans-test.psd') do |psd|
	@psd = psd.tree.to_hash #Creates nested hash from PSD hierarchy
	ap "The layer's name is #{psd.tree.descendant_layers.first.name}" 
	ap "The layer's text reads #{psd.tree.descendant_layers.first.text[:value]}" 
end







