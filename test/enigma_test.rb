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

  def test_enigma_can_make_a_key
    assert_equal 5, @enigma.key.length
    assert_instance_of Integer, @enigma.key[0].to_i
    assert_instance_of String, @enigma.key.class
  end

end
