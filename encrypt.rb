require_relative './lib/enigma'

input = ARGV
plain_message_path = File.open("files/#{input[0]}")
encrypted_message_file = File.open("files/#{input[1]}", "w" )

enigma = Enigma.new

message = plain_message_path.read.chomp
enigma.encrypt("#{message}", "17/01/21", "11111")

p new_message = enigma.encrypt("#{message}", "17/01/21", "11111")[:encryption]

encrypted_message_file.write("#{new_message}")
encrypted_message_file.close
encrypted_message_file = File.open("files/#{input[1]}", "r" )
new_thing = encrypted_message_file.read

p enigma.decrypt("#{new_thing}", "170121", "11111")
