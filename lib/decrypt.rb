require_relative './enigma'

class Decrypt < Enigma

  def decrypt(message, key=key_generator, date=todays_date)
    date = check_date(date)
    encrypted_message = decryption(message, key, date)
    results = {:decryption => encrypted_message, :date => date, :key => key}
  end

  def decryption(message, key, date)
    shifts = make_shifts(key, date)
    new_message = ''
    count = 0
    message.each_char do |char|
      new_message += decryption_character_checker(char, shifts[count])
      count += 1
      if count > 3
        count = 0
      end
    end
    new_message
  end

  def decryption_character_checker(char, shift)
    if char.ord == 32
      new_character = counter_subtraction(26, shift)
      "#{range_of_characters[new_character]}"
    elsif char.ord < 97 || char.ord > 122
      char
    else
      new_character = counter_subtraction((char.ord) - 97, shift)
      "#{range_of_characters[new_character]}"
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
