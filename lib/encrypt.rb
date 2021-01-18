require_relative './enigma'

class Encrypt < Enigma

  def encrypt(string, key=key_generator, date=todays_date)
    date = check_date(date)
    encrypted_message = encryption(string, date, key)
    results = {:encryption => encrypted_message, :date => date, :key => key}
  end

  def encryption(string, date, key)
    string = string.downcase
    shifts = make_shifts(key, date)
    new_message = ''
    count = 0
    string.each_char do |char|
      new_message += encryption_character_checker(char, shifts[count])
      count += 1
      if count > 3
        count = 0
      end
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
