require_relative './enigma'

class Decrypt < Enigma

  def decrypt(message, date, key)
    shifts = make_shifts(key, date)
    new_word = ''
    count = 0
    message.each_char do |char|
      new_word += decryption_character_checker(char, shifts[count])
      count += 1
      if count > 3
        count = 0
      end
    end
    new_word
  end

  def decryption_character_checker(char, shift)
    if char.ord == 32
      new_character = counter_subtraction(26, shift)
      "#{@range_of_characters[new_character]}"
    elsif char.ord < 97 || char.ord > 122
      char
    else
      new_character = counter_subtraction((char.ord) - 97, shift)
      "#{@range_of_characters[new_character]}"
    end
  end

  def counter_subtraction(starting_place, shift)
    until shift == 0
      if starting_place <= 0
        starting_place = 27
      end
      starting_place -= 1
      shift -= 1
    end
    starting_place
  end
end
