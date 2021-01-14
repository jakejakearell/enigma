require 'time'
require_relative './test_helper'

require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_has_exists
    assert_instance_of Enigma, @enigma
  end

  def test_returns_today_as_useable_date
    assert_equal "011421", @enigma.todays_date
  end

end
