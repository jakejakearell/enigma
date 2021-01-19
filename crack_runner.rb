require_relative './lib/cracking'

ARGV
enigma = Cracking.new
info = enigma.crack(ARGV[0], ARGV[2])
require "pry"; binding.pry
destination_file = File.open("files/#{ARGV[1]}", "w" )
destination_file.write("#{info[:decryption]}")

puts "Created '#{ARGV[1]}' with date #{ARGV[2]}"
