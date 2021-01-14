require 'time'

class Enigma

  def initialize
  end

  def todays_date
    Time.new.strftime("%m/%d/%y").delete("/")
  end
  
end
