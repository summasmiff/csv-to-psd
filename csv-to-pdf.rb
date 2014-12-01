require 'rubygems'
require 'csv'
require 'prawn'
require 'pdf/reader'
require 'awesome_print'
require 'open-uri'

#Problem: Given CSV of English labels in a Photoshop doc with corresponding labels in another language. 
#Find each English phrase as a text-obj in Photoshop, replace text with the other language.
#If successful, mark the CSV in some way

#translation csv to dictionary hash
@csv = Hash[ CSV.read('trans-test.csv').map do |row|
	[ row[0].to_s, (row[1].to_s unless row[1] == nil) ] 
	end 
]
ap @csv

#Extract text from PDF, convert to string.
reader = PDF::Reader.new('trans-test.pdf')

reader.pages.each do |page|
	@pdf = String.new(page.text)
	ap @pdf
end

#Translate
@csv.each { |key, value| @pdf = @pdf.gsub(key, value) if value != nil }

ap @pdf

#Write to PDF
pdf = Prawn::Document.new
pdf.text "#{@pdf}"
pdf.render_file "trans-test-done.pdf"








