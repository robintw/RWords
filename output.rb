def print_output(words)
  puts "<p>There are #{words.length} results.</p>"
  puts "<ul class=\"nav noindent\">"
  words.each { |word|
    puts "<li>" + word + "</li>"
  }
  puts "</ul>"
end
