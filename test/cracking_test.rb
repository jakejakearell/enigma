require 'time'
require_relative './test_helper'
require './lib/enigma'
require './lib/cracking'
require 'mocha/minitest'


class CrackingTest < Minitest::Test
  def setup
    @cracking = Cracking.new
  end

  def test_it_can_crack
    assert_equal "hello world end", @cracking.crack("vjqtbeaweqihssi", "291018")
  end
end
