require_relative './enigma'

class Cracking < Enigma

    def crack(message, date=todays_date)
      end_characters = message[-4..-1].split("")
      ordinal = end_characters.map do |character|
        (character.ord) - 97
      end

      characters_assinger = message.length % 4

      if characters_assinger % 4 == 0
        characters = { :a => ordinal[0], :b => ordinal[1], :c => ordinal[2], :d => ordinal[3]}
      elsif characters_assinger % 4 == 1
        characters = { :a => ordinal[3], :b => ordinal[0], :c => ordinal[1], :d => ordinal[2]}
      elsif characters_assinger % 4 == 2
        characters= {:a => ordinal[2], :b => ordinal[3], :c => ordinal[0], :d => ordinal[1]}
      else characters_assinger % 4 == 3
        characters = {:a => (ordinal[1]), :b => ordinal[2], :c => ordinal[3], :d => ordinal[0]}
      end


      # [26, 4, 13, 3]

    end



end
