require 'rubygems'
require 'csv'
require 'psd'

#Problem: Given CSV of English labels in a Photoshop doc with corresponding labels in another language. 
#Find each English phrase as a text-obj in Photoshop, replace text with the other language.
#If successful, mark the CSV in some way
#If unsuccessful, mark CSV in a different way

#read the csv file
CSV.foreach('trans-test.csv') do |row| 
	puts row.inspect
	if row[1] != nil #testing markings
		row << "*"
	else
		row << "X"
	end
	puts row.inspect
end

#Open the PSD
PSD.open('trans-test.psd') do |psd|
	hash = psd.tree.to_hash
	new_hash = hash.each do |k, v|
		gsub('cat', 'dog')if v == '\"cat\"' #test str for time being
	end
	p new_hash.inspect
end







