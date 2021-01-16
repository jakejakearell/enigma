require 'time'

class Enigma

  def initialize
    @range_of_characters = ("a".."z").to_a << " "
  end

  def todays_date
    Time.new.strftime("%d/%m/%y").delete("/")
  end

  def key_generator
    key = ''
    characters = ("0".."9").to_a
    5.times do
      key += characters.sample
    end
    key
  end

  def date_formatter(arguement)
    formatted_date = ''
    new_date = Date._strptime(arguement.to_s, '%d-%m-%Y')
    formatted_date += new_date[:mday].to_s.rjust 2 ,"0"
    formatted_date += new_date[:mon].to_s.rjust 2 ,"0"
    formatted_date += new_date[:year].to_s
  end

  def encrypt(string, date=nil, key=key_generator)
    # I Think there is a more elegant way to do this. Circle back
    if date.nil?
      date = todays_date
    end
    results = {:encryption => string, :date => date, :key => key}
  end

  def offsets(date)
    results = []
    squared = date.to_i ** 2
    results << squared.to_s[-4].to_i
    results << squared.to_s[-3].to_i
    results << squared.to_s[-2].to_i
    results << squared.to_s[-1].to_i
    results
    #Surely there has to be a way to use iteration to solve this.
  end

  def keys(date)
    results = []
    counter = 0
    4.times do
      results << (date[counter] + date[(counter +1)]).to_i
      counter += 1
    end
    
    results
  end

  def shifts(keys, dates)
    counter = 0
    results = []
    4.times do
      results << (offsets(dates)[counter] + keys(keys)[counter])
      counter += 1
    end
    results
  end

  def encryption(arguement)
    new_shifts = shifts("02715", "040895")
    new_word = ''
    count = 0

    arguement.each_char do |char|
      new_character = counter_method((char.ord) - 97, new_shifts[count])

      if char.ord == 32
        new_word += ' '
      else
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
      if starting_place == 27
        starting_place = 0
      end
      shift -= 1
    end
    starting_place
  end

end
