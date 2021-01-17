require_relative './lib/enigma'

ARGV
encrypted_message_file = File.open("files/#{ARGV[0]}", "r" )
destination_file = File.open("files/#{ARGV[1]}", "w" )
message = encrypted_message_file.read

enigma = Enigma.new
decrypted_message = enigma.decrypt("#{message}", "#{ARGV[2]}", "#{ARGV[3]}")
destination_file.write("#{decrypted_message}")
puts "Created '#{ARGV[1]}' with the key #{ARGV[3]} and date #{ARGV[2]}"
