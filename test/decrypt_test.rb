require 'time'
require_relative './test_helper'
require './lib/enigma'
require './lib/decrypt'
require 'mocha/minitest'


class DecryptTest < Minitest::Test
  def setup
    @decrypt = Decrypt.new
  end

  def test_decrypt_returns_hash
    decryption = @decrypt.decrypt("gkwvnyxtwtk", "10001", "160121")
    assert_equal "160121", decryption[:date]
    assert_equal "test string",  decryption[:decryption]
    assert_equal 5, decryption[:key].length
  end

  def test_decrypt_strings
    assert_equal "hello world!?..", @decrypt.decryption("keder ohulw!?..", "02715", "040895" )
    assert_equal "hello world end", @decrypt.decryption("vjqtbeaweqihssi", "08304", "291018",)
    assert_equal "boy howdy, i ate a lot arfggh", @decrypt.decryption("ptchvtall,eqnfymnfetbyeieklov", "08304",  "291018")
    assert_equal "aaaaaaaa", @decrypt.decryption("ofmyofmy", "08374", "291018")
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
