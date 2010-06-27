require 'rubygems'
require 'sqlite3'

exclude = true

input = gets.chomp!
input.upcase!
letters = input.split("")

letter_counts = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

db = SQLite3::Database.new('words.db')

sql_command = "SELECT word FROM words WHERE 1=1"

letters.each { |letter|
	index = letter[0] - 65
	letter_counts[index] = letter_counts[index] + 1
}

alpha_index = 65

letter_counts.each { |lc|
	if (lc > 0 || exclude)
		sql_command << " AND " + alpha_index.chr + " = " + lc.to_s
	end  
	alpha_index = alpha_index + 1
}

puts sql_command

db.execute(sql_command) { |row|
	puts row[0]
	puts "<li>" + row['word'] + "</li>"
}

puts "Done"
