require_relative './lib/enigma'


input = ARGV
enigma = Enigma.new

p enigma.encrypt("#{input[0]}")
