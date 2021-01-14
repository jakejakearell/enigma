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

end
