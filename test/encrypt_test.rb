require 'time'
require_relative './test_helper'
require './lib/enigma'
require './lib/encrypt'
require 'mocha/minitest'

class EncryptTest < Minitest::Test
  def setup
    @encrypt = Encrypt.new
  end

  def test_encrypt_arguments
    values = @encrypt.encrypt("Test String", "10001", "16/01/21")
    assert_equal "160121", values[:date]
    assert_equal "gkwvnyxtwtk",  values[:encryption]
    assert_equal 5, values[:key].length
  end

  def test_encrypting_strings
    assert_equal "keder ohulw!?..", @encrypt.encryption("HELLO world!?..", "040895", "02715" )
    assert_equal "vjqtbeaweqihssi", @encrypt.encryption("hello world end",  "291018", "08304")
    assert_equal "ptchvtall,eqnfymnfetbyeieklov", @encrypt.encryption("Boy HOwdy, I ate a lot arfggh",  "291018", "08304")
    assert_equal "ofmyo", @encrypt.encryption("AAAAA",  "291018", "08374")
  end

  def test_counter_method
    assert_equal 0, @encrypt.counter_method(26, 28)
    assert_equal 1, @encrypt.counter_method(2, 26)
  end

  def test_encryption_character_checker
    assert_equal "b", @encrypt.encryption_character_checker("a", 28)
    assert_equal "i", @encrypt.encryption_character_checker("z", 10)
  end
end
