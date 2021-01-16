require 'time'
require_relative './test_helper'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_has_exists
    assert_instance_of Enigma, @enigma
  end

  def test_returns_today_as_useable_date
    date = @enigma.todays_date
    assert_equal "160121", @enigma.date_formatter(date)
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
    values = @enigma.encrypt("Test String", "16/01/21", "10001")
    assert_equal "160121", values[:date]
    assert_equal "gkwv yxtwtk",  values[:encryption]
    assert_equal 5, values[:key].length
  end

  def test_offsets
    results = @enigma.offsets("040895")

    assert_equal 1, results[0]
    assert_equal 0, results[1]
    assert_equal 2, results[2]
    assert_equal 5, results[3]
  end

  def test_keys
    results = @enigma.keys("02715")

    assert_equal 2, results[0]
    assert_equal 27, results[1]
    assert_equal 71, results[2]
    assert_equal 15, results[3]
  end

  def test_final_shift
    results = @enigma.make_shifts("02715", "040895")

    assert_equal 3, results[0]
    assert_equal 27, results[1]
    assert_equal 73, results[2]
    assert_equal 20, results[3]
  end

  def test_encrypting_strings
    assert_equal "keder ohulw!?..",  @enigma.encryption("hello world!?..", "040895", "02715" )
  end
end
