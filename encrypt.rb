require_relative './lib/encrypt'

ARGV
plain_message_path = File.open("files/#{ARGV[0]}")
encrypted_message_file = File.open("files/#{ARGV[1]}", "w" )
message = plain_message_path.read.chomp

enigma = Encrypt.new
info = enigma.encrypt("#{message}")
encrypted_message_file.write("#{info[:encryption]}")

puts "Created '#{ARGV[1]}' with the key #{info[:key]} and date #{info[:date]}"
