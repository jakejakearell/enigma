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

  def date_checker(date)
    new_date = Time.parse(date.to_s)
  end

end
