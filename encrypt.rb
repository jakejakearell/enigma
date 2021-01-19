require_relative './lib/encrypt'

ARGV
enigma = Encrypt.new
info = enigma.encrypt(ARGV[0])
encrypted_message_file = File.open("files/#{ARGV[1]}", "w" )
encrypted_message_file.write("#{info[:encryption]}")

puts "Created '#{ARGV[1]}' with the key #{info[:key]} and date #{info[:date]}"
