require_relative './enigma'

class Encrypt < Enigma

  def encrypt(message, key=key_generator, date=todays_date)
    message = assess_message(message)
    date = check_date(date)
    encrypted_message = encryption(message, date, key)
    {:encryption => encrypted_message, :date => date, :key => key}
  end

  def encryption(message, date, key)
    message = message.downcase
    shifts = make_shifts(key, date)
    new_message = ''
    message.each_char do |char|
      new_message += encryption_character_checker(char, shifts[new_message.length % 4])
    end
    new_message
  end

  def encryption_character_checker(char, shift)
    if char.ord == 32
      new_character = counter_method(27, shift)
      "#{range_of_characters[new_character]}"
    elsif char.ord < 97 || char.ord > 122
      char
    else
      new_character = counter_method((char.ord) - 97, shift)
      "#{range_of_characters[new_character]}"
    end
  end

  def counter_method(starting_place, shift)
    until shift == 0
      starting_place += 1
      if starting_place >= 27
        starting_place = 0
      end
      shift -= 1
    end
    starting_place
  end
end
