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
    assert_equal "140121", @enigma.todays_date
  end

  def test_enigma_can_make_a_key
    key_1 = @enigma.key_generator
    key_2 = @enigma.key_generator

    assert_equal true, key_1 != key_2
    assert_equal 5, @enigma.key_generator.length
    assert_instance_of Integer, @enigma.key_generator[0].to_i
    assert_equal String, @enigma.key_generator.class
  end

  def test_if_provided_date_it_is_useable
    assert_equal "021192", @enigma.date_formatter("2-11-92")
  end

  def test_encrypt_arguments
    values = @enigma.encrypt("Test String")
    assert_equal "140121", values[:date]
    assert_equal "Test String",  values[:encryption]
    assert_equal 5, values[:key].length

  end

end
