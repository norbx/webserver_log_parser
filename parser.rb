require './config/application'

file = CSV.read("./#{ARGV[0]}")

puts 'Enter a key to sort logs by (views/unique_views):'
sort_by = $stdin.gets.chomp

ap Parser::Main.new(file, sort_by).call
