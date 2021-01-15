require 'time'

class Enigma

  def initialize
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
    results << (date[0] + date[1]).to_i
    results << (date[1] + date[2]).to_i
    results << (date[2] + date[3]).to_i
    results << (date[3] + date[4]).to_i

    results
  end

  def shifts(keys, dates)
    key_shift = keys(keys)
    date_shift = offsets(dates)
    counter = 0
    results = []
    4.times do
      results << (date_shift[counter] + key_shift[counter])
      counter += 1
    end
    results
  end
end
