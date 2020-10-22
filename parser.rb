require './config/application'

file = CSV.read("./#{ARGV[0]}")

puts 'Enter a key to sort webpages by (:views, :unique_views):'
sort_by = gets

puts Parser::Main.new(file, sort_by).call
