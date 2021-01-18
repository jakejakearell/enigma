require 'time'
require_relative './test_helper'
require './lib/enigma'
require './lib/decrypt'
require 'mocha/minitest'


class DecryptTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    @decrypt = Decrypt.new
  end

  def test_decrypt_strings
    assert_equal "hello world!?..", @decrypt.decrypt("keder ohulw!?..", "040895", "02715" )
    assert_equal "hello world end", @decrypt.decrypt("vjqtbeaweqihssi",  "291018", "08304")
    assert_equal "boy howdy, i ate a lot arfggh", @decrypt.decrypt("ptchvtall,eqnfymnfetbyeieklov",  "291018", "08304")
    assert_equal "aaaaaaaa", @decrypt.decrypt("ofmyofmy",  "291018", "08374")
  end

  def test_counter_subtraction
    assert_equal 4, @decrypt.counter_subtraction(26, 22)
    assert_equal 23, @decrypt.counter_subtraction(26, 30)
  end

  def test_decryption_character_checker
    assert_equal "b", @decrypt.decryption_character_checker("a", 26)
    assert_equal "w", @decrypt.decryption_character_checker("z", 30)
  end
end
