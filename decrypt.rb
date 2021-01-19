require_relative './lib/decrypt'

ARGV
enigma = Decrypt.new
info = enigma.decrypt(ARGV[0], ARGV[2], ARGV[3])

destination_file = File.open("files/#{ARGV[1]}", "w" )
destination_file.write("#{info[:decryption]}")

puts "Created '#{ARGV[1]}' with the key #{ARGV[2]} and date #{ARGV[3]}"
