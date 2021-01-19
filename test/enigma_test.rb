require 'time'
require_relative './test_helper'
require './lib/enigma'
require 'mocha/minitest'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @file = mock
    @file.stubs(:name).returns("test.txt")
  end

  def test_it_has_range_of_characters
    assert_equal 27, @enigma.range_of_characters.length
    assert_equal "a", @enigma.range_of_characters[0]
    assert_equal " ", @enigma.range_of_characters[26]
  end

  def test_returns_today_as_useable_date
    date = @enigma.todays_date
    assert_equal "180121", @enigma.date_formatter(date)
  end

  def test_assesses_what_to_do_with_message
    assert_equal String, @enigma.assess_message(@file.name).class
    assert_equal String, @enigma.assess_message("not a file").class
    assert_equal String, @enigma.assess_message(12312).class
  end

  def test_enigma_can_make_a_key
    key_1 = @enigma.key_generator
    key_2 = @enigma.key_generator

    assert_equal true, key_1 != key_2
    assert_equal 5, @enigma.key_generator.length
    assert_instance_of Integer, @enigma.key_generator[0].to_i
    assert_equal String, @enigma.key_generator.class
  end

  def test_it_can_format_a_date
    assert_equal "021192", @enigma.date_formatter("2-11-92")
  end

  def test_it_will_return_a_useable_date
    assert_equal "040895", @enigma.check_date("040895")
    assert_equal "040895", @enigma.check_date("04-08-95")
    assert_equal "040895", @enigma.check_date("04/08/95")
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

  # def test_it_can_crack
  #   skip
  #   assert_equal "hello world end", @enigma.crack("vjqtbeaweqihssi", "291018")
  # end
end
