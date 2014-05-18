require './concordance'

puts "Please enter the input file path:"
filepath = gets.chomp
begin
  f = File.open(filepath, 'r')
  text = f.read
  c = Concordance.new(text)
rescue Exception => e
  puts "Something went wrong. #{e.message}"
end  
