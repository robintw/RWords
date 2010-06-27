require 'rubygems'
require 'cgi'
require 'sqlite3'

def letter_inclusion(letters, exclude)
  # Initialise letter counts array
  letter_counts = [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]

  # Open database
  db = SQLite3::Database.new('words.db')

  sql_command = "SELECT word FROM words WHERE 1=1"

  # Update letter_counts by counting the letters in the letters array
  letters.each { |letter|
    if (letter[0] < 65)
      break
    end
    index = letter[0] - 65
    letter_counts[index] = letter_counts[index] + 1
  }

  # The ASCII value for A
  alpha_index = 65

  # Create the SQL statement
  letter_counts.each { |lc|
    if (lc > 0 || exclude)
      sql_command << " AND " + alpha_index.chr + " = " + lc.to_s
    end
    alpha_index = alpha_index + 1
  }

  words = Array.new

  # Execute the SQL command
  db.execute(sql_command) { |row|
    words << row[0]
  }
  return words
end

def include_word(word)
  # Open words file
  f = File.new("words.txt", "r")

  word.upcase!

  words = Array.new

  # For each word in the file, check against the word given
  f.each_line { |line|
    if (line.include?(word))
      words << line
    end
  }

  # Close words file
  f.close

  return words
end

def starts_with(letter)
  # Open words file
  f = File.new("words.txt", "r")

  words = Array.new

  # For each word in the file, check against the word given
  f.each_line { |line|
    if (line[0].chr == letter)
      words << line
    end
  }

  # Close words file
  f.close

  return words
end

def regexp(source)
  altered_source = '\b' + source + '\b'
  rexp = Regexp.new(altered_source)

  # Open words file
  f = File.new("words.txt", "r")

  words = Array.new

  # For each word in the file, check against the word given
  f.each_line { |line|
    if (rexp =~ line)
      words << line
    end
  }

  # Close words file
  f.close

  return words
end

