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
@csv = Hash[ CSV.read('gold-bug-trans.csv').map do |row|
	[ row[0].to_s, (row[1].to_s unless row[1] == nil) ] 
	end 
]
ap @csv

#Extract text from PDF, convert to an array of strings, one for each page.
reader = PDF::Reader.new('gold-bug.pdf')

text = []

reader.pages.each do |page|
	str = String.new(page.text)
	text.push str
end

#Translate
text.each do |i|
	i.to_s.strip.gsub!(/\s+\n?/, ' ')
	@csv.each { |key, value| i.to_s.gsub!(key, value) if value != nil }
end

#Write to PDF
pdf = Prawn::Document.new
text.each { |i| pdf.text "#{i.to_s.strip.gsub!(/\s+\n?/, ' ')}" }
pdf.render_file "gold-bug-done.pdf"








