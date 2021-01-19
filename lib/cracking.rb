require_relative './decrypt'

class Cracking < Decrypt

    def ordinal_values(message)
      end_characters = message[-4..-1].split("")
      ordinal = end_characters.map do |character|
        if character.ord == 32
            26
        else
          (character.ord) - 97
        end
      end
    end

    def shift_location(message)
      ordinals = ordinal_values(message)
      characters_assinger = message.length % 4
      if characters_assinger % 4 == 0
          { :a => (1+ordinals[0]), :b => (4-ordinals[1]), :c => (13-ordinals[2]), :d => (3-ordinals[3])}
      elsif characters_assinger % 4 == 1
         { :a => (3-ordinals[3]), :b => (1+ordinals[0]), :c => (4-ordinals[1]), :d => (13-ordinals[2])}
      elsif characters_assinger % 4 == 2
         {:a => (13-ordinals[2]), :b => (3-ordinals[3]), :c => (1+ordinals[0]), :d => (4-ordinals[1])}
      else characters_assinger % 4 == 3
         {:a => (4-ordinals[1]), :b => (13-ordinals[2]), :c => (3-ordinals[3]), :d => (1+ordinals[0])}
      end
    end

    def crack(message)
      message = message.downcase
      shifts = shift_location(message).values.map {|value| value.abs}
      new_message = ''
      message.each_char do |char|
        new_message += decryption_character_checker(char, shifts[new_message.length % 4])
      end
      new_message
    end

end
