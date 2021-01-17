require_relative './lib/enigma'


input = ARGV
plain_message_path = File.open("files/#{input[0]}")
p message = plain_message_path.read.chomp
path_to_encrypted_message = File.open("files/#{input[1]}")
# require "pry"; binding.pry
# 0

enigma = Enigma.new
# message = "Hi how are you?"
enigma.encrypt("#{message}", "17/01/21", "11111")
new_message = enigma.encrypt("#{message}", "17/01/21", "11111")[:encryption]
p enigma.decrypt("#{new_message}", "170121", "11111")
