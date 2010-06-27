require 'rubygems'
require 'sqlite3'

def count_letters(word)
	letters = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
	word.upcase!
	word.each_byte { |b|
		if (b < 65)
			break
		end
		index = b - 65
		letters[index] = letters[index] + 1
	}
	return letters
end

def remove_db_file()
	db = SQLite3::Database.new('words.db')
	db.execute <<SQL
	
	DROP TABLE words;
	
SQL
end

def create_db_file()
	db = SQLite3::Database.new('words.db')
	db.execute <<SQL
		
		CREATE TABLE words (
			id INTEGER PRIMARY KEY,
			word VARCHAR(255) NOT NULL,
			a INTEGER DEFAULT 0,
			b INTEGER DEFAULT 0,
			c INTEGER DEFAULT 0,
			d INTEGER DEFAULT 0,
			e INTEGER DEFAULT 0,
			f INTEGER DEFAULT 0,
			g INTEGER DEFAULT 0,
			h INTEGER DEFAULT 0,
			i INTEGER DEFAULT 0,
			j INTEGER DEFAULT 0,
			k INTEGER DEFAULT 0,
			l INTEGER DEFAULT 0,
			m INTEGER DEFAULT 0,
			n INTEGER DEFAULT 0,
			o INTEGER DEFAULT 0,
			p INTEGER DEFAULT 0,
			q INTEGER DEFAULT 0,
			r INTEGER DEFAULT 0,
			s INTEGER DEFAULT 0,
			t INTEGER DEFAULT 0,
			u INTEGER DEFAULT 0,
			v INTEGER DEFAULT 0,
			w INTEGER DEFAULT 0,
			x INTEGER DEFAULT 0,
			y INTEGER DEFAULT 0,
			z INTEGER DEFAULT 0
		);
SQL
end

#remove_db_file()
create_db_file()

#Open the file
f = File.new("words.txt", "r")

puts Dir.pwd

#Open the database
db = SQLite3::Database.new('words.db')

f.each_line { |line|
	letters = count_letters(line)
	puts "Adding " + line
	#puts letters.join(" ")
	sql = "INSERT INTO words (word, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z) VALUES ("
	sql = sql + "\"" + line + "\""
	letters.each { |letter|
		sql = sql + ", " + letter.to_s
	}
	sql = sql + ");"
	db.execute sql
}
