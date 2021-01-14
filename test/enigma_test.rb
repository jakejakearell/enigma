require_relative './test_helper'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @engima = Enigma.new
  end

  def test_it_has_exists
    assert_instance_of Enigma, @engima
  end

end
