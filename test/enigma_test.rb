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
    assert_equal "180121", @enigma.date_formatter(date)
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
    assert_equal "gkwvnyxtwtk",  values[:encryption]
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
    assert_equal "keder ohulw!?..", @enigma.encryption("HELLO world!?..", "040895", "02715" )
    assert_equal "vjqtbeaweqihssi", @enigma.encryption("hello world end",  "291018", "08304")
    assert_equal "ptchvtall,eqnfymnfetbyeieklov", @enigma.encryption("Boy HOwdy, I ate a lot arfggh",  "291018", "08304")
    assert_equal "ofmyo", @enigma.encryption("AAAAA",  "291018", "08374")
  end

  def test_decrypt_strings
    assert_equal "hello world!?..", @enigma.decrypt("keder ohulw!?..", "040895", "02715" )
    assert_equal "hello world end", @enigma.decrypt("vjqtbeaweqihssi",  "291018", "08304")
    assert_equal "boy howdy, i ate a lot arfggh", @enigma.decrypt("ptchvtall,eqnfymnfetbyeieklov",  "291018", "08304")
    assert_equal "aaaaaaaa", @enigma.decrypt("ofmyofmy",  "291018", "08374")
  end

  def test_counter_method
    assert_equal 0, @enigma.counter_method(26, 28)
    assert_equal 1, @enigma.counter_method(2, 26)
  end

  def test_counter_subtraction
    assert_equal 4, @enigma.counter_subtraction(26, 22)
    assert_equal 23, @enigma.counter_subtraction(26, 30)
  end

  def test_encryption_character_checker
    assert_equal "b", @enigma.encryption_character_checker("a", 28)
    assert_equal "i", @enigma.encryption_character_checker("z", 10)
  end

  def test_decryption_character_checker
    assert_equal "b", @enigma.decryption_character_checker("a", 26)
    assert_equal "w", @enigma.decryption_character_checker("z", 30)
  end

  def test_it_can_crack
    assert_equal "hello world end", @enigma.crack("vjqtbeaweqihssi", "291018")
  end
end
