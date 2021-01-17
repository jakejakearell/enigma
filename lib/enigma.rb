require 'time'

class Enigma

  def initialize
    @range_of_characters = ("a".."z").to_a << " "
  end

  def todays_date
    Time.new.strftime("%d/%m/%y")
  end

  def key_generator
    key = ''
    characters = ("0".."9").to_a
    5.times do
      key += characters.sample
    end
    key
  end

  def date_formatter(date)
    date = date.gsub('/', '-')
    new_date = Date._strptime(date.to_s, '%d-%m-%Y')
    new_date.reduce('') do |memo, date|
      memo += date[1].to_s.rjust 2 ,"0"
    end
  end

  def encrypt(string, date=todays_date, key=key_generator)
    date = date_formatter(date)
    encrypted_message = encryption(string, date, key)
    results = {:encryption => encrypted_message, :date => date, :key => key}
  end

  def offsets(date)
    counter = 4
    results = []
    squared = date.to_i ** 2
    4.times do
      results << squared.to_s[-(counter)].to_i
      counter -= 1
    end
    results
  end

  def keys(key)
    results = []
    counter = 0
    4.times do
      results << (key[counter] + key[(counter +1)]).to_i
      counter += 1
    end
    results
  end

  def make_shifts(keys, dates)
    counter = 0
    results = []
    4.times do
      results << (offsets(dates)[counter] + keys(keys)[counter])
      counter += 1
    end
    results
  end

  def encryption(string, date, key)
    string = string.downcase
    shifts = make_shifts(key, date)
    new_word = ''
    count = 0
    string.each_char do |char|
      if char.ord == 32
        new_character = counter_method(27, shifts[count])
        new_word += "#{@range_of_characters[new_character]}"
      elsif char.ord < 97 || char.ord > 122
        new_word += char
      else
        new_character = counter_method((char.ord) - 97, shifts[count])
        new_word += "#{@range_of_characters[new_character]}"
      end

      count += 1
      if count > 3
        count = 0
      end
    end

    new_word
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


  def decrypt(message, date, key)
    shifts = make_shifts(key, date)
    new_word = ''
    count = 0
    message.each_char do |char|
      if char.ord == 32
        # require "pry"; binding.pry
        new_character = counter_subtraction(26, shifts[count])
        new_word += "#{@range_of_characters[new_character]}"
      elsif char.ord < 97 || char.ord > 122
        new_word += char
      else
        new_character = counter_subtraction((char.ord) - 97, shifts[count])
        new_word += "#{@range_of_characters[new_character]}"
      end

      count += 1
      if count > 3
        count = 0
      end
    end
    new_word

  end

  def counter_subtraction(starting_place, shift)
    if starting_place == 0
      shift += 1
    end

    until shift == 0
      starting_place -= 1
      if starting_place <= 0
        starting_place = 27
      end
      shift -= 1
    end

    if starting_place == 27
      starting_place = 0
    end

    starting_place
  end
end
