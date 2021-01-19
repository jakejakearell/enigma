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
    new_date.reduce('') do |memo, date_portion|
      memo += date_portion[1].to_s.rjust 2 ,"0"
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
    squared.map do |number|
      number.to_i
    end
  end

  def keys(key)
    results = []
    until results.length == 4
      key.split("").reduce do |intial_key, next_key|
        results << (intial_key + next_key).to_i
      next_key
      end
    end
    results
  end

  def make_shifts(keys, dates)
    keys = keys(keys)
    offsets = offsets(dates)
    keys.map.with_index do |key, index|
      key + offsets[index]
    end
  end
end
