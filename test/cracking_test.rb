require 'time'
require_relative './test_helper'
require './lib/enigma'
require './lib/cracking'
require 'mocha/minitest'


class CrackingTest < Minitest::Test
  def setup
    @cracking = Cracking.new
  end

  def test_it_find_ordinal_values
    assert_equal [7, 18, 18, 8], @cracking.ordinal_values("vjqtbeaweqihssi")
    assert_equal [26, 4, 13, 3], @cracking.ordinal_values(" end")
  end

  def test_it_can_figure_out_the_location_of_shifts
    assert_equal 18, @cracking.shift_location("vjqtbeaweqihssi")[:a]
    assert_equal 18, @cracking.shift_location("vjqtbeaweqihssi")[:b]
    assert_equal 8, @cracking.shift_location("vjqtbeaweqihssi")[:c]
    assert_equal 7, @cracking.shift_location("vjqtbeaweqihssi")[:d]
    assert_nil @cracking.shift_location("vjqtbeaweqihssi")[:e]

  end
end
