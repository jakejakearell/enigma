require 'time'

class Enigma

  def range_of_characters
    ("a".."z").to_a << " "
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

  def check_date(date)
    if !date.include?('/') && !date.include?('-')
      date[0..5]
    else
      date_formatter(date)
    end
  end

  def date_formatter(date)
    date = date.gsub('/', '-')
    new_date = Date._strptime(date.to_s, '%d-%m-%Y')
    new_date.reduce('') do |memo, date|
      memo += date[1].to_s.rjust 2 ,"0"
    end
  end

  def assess_message(message)
    if File.exist?("files/#{message}")
      file = File.open("files/#{message}", "r")
      message = file.read
    else
      message.to_s
    end
  end

  def offsets(date)
    squared = (date.to_i ** 2).to_s[-4..-1].split("")
    results = squared.map do |number|
      number.to_i
    end
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
    keys = keys(keys)
    offsets = offsets(dates)
    results = keys.map.with_index do |key, index|
      key + offsets[index]
    end
  end

  # def crack(message, date=todays_date)
  #   end_characters = message[-4..-1].split("")
  #   ordinal = end_characters.map do |character|
  #     (character.ord) - 97
  #   end
  #
  #   characters_assinger = message.length % 4
  #
  #   if characters_assinger % 4 == 0
  #     characters = { :a => ordinal[0], :b => ordinal[1], :c => ordinal[2], :d => ordinal[3]}
  #   elsif characters_assinger % 4 == 1
  #     characters = { :a => ordinal[3], :b => ordinal[0], :c => ordinal[1], :d => ordinal[2]}
  #   elsif characters_assinger % 4 == 2
  #     characters= {:a => ordinal[2], :b => ordinal[3], :c => ordinal[0], :d => ordinal[1]}
  #   else characters_assinger % 4 == 3
  #     characters = {:a => (ordinal[1]), :b => ordinal[2], :c => ordinal[3], :d => ordinal[0]}
  #   end
  #   require "pry"; binding.pry
  #
  #   [26, 4, 13, 3]
  #
  # end

end
