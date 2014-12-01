require 'rubygems'
require 'csv'
require 'psd'
require 'awesome_print'

#Problem: Given CSV of English labels in a Photoshop doc with corresponding labels in another language. 
#Find each English phrase as a text-obj in Photoshop, replace text with the other language.
#If successful, mark the CSV in some way

#translation csv to dictionary hash
@csv = Hash[ CSV.read('trans-test.csv').map do |row|
	[ row[0].to_s, (row[1].to_s unless row[1] == nil) ] 
	end 
]

#Test hash => replace with PSD hash
@test_h = {:Patrick => "monkey", :Chief => "cat", :Polly => "fish", :Smaug => "dragon"}

#Open the PSD
#### PSD gem does not support writing to PSDs ####
PSD.open('trans-test.psd') do |psd|
	ap "The layer's name is #{psd.tree.descendant_layers.first.name}" 
	ap "The layer's text reads #{psd.tree.descendant_layers.first.text[:value]}" 
end

#Check PSD for matches, and change value using dictionary
file = ARGV[0] || 'trans-test.psd'
psd = PSD.new(file)

psd.layers.each do |layer|
	next if layer.folder? || layer.hidden? || layer.folder_end?
		@csv.each do |key, value|
			if layer.name == key && value != nil
				layer.name = value 
			end
			if layer.text[:value] == key && value != nil
				layer.text[:value] = value
			end
		end
end

ap "The layer's new name is #{psd.tree.descendant_layers.first.name}" 
ap "The layer's new text reads #{psd.tree.descendant_layers.first.text[:value]}" 









