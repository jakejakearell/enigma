require_relative './enigma'

class Encrypt < Enigma
  attr_reader :info

  def initialize(message, key=key_generator, date=todays_date)
    date = date_formatter(date)
    @info = {:date => date,
            :key => key,
            :message => message
            }
  end


  # def encrypt(string, date=todays_date, key=key_generator)
  #   date = date_formatter(date)
  #   encrypted_message = encryption(string, date, key)
  #   results = {:encryption => encrypted_message, :date => date, :key => key}
  # end

  def encryption(string, date, key)
    string = string.downcase
    shifts = make_shifts(key, date)
    new_word = ''
    count = 0
    string.each_char do |char|
      new_word += encryption_character_checker(char, shifts[count])
      count += 1
      if count > 3
        count = 0
      end
    end
    new_word
  end

  def encryption_character_checker(char, shift)
    if char.ord == 32
      new_character = counter_method(27, shift)
      "#{@range_of_characters[new_character]}"
    elsif char.ord < 97 || char.ord > 122
      char
    else
      new_character = counter_method((char.ord) - 97, shift)
      "#{@range_of_characters[new_character]}"
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
