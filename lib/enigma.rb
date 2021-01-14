require 'time'

class Enigma

  def initialize
  end

  def todays_date
    Time.new.strftime("%m/%d/%y").delete("/")
  end

  def key_generator
    key = ''
    characters = ("0".."9").to_a
    5.times do
      key += characters.sample
    end
    key
  end

end
