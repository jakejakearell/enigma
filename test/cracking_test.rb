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
    assert_equal 14, @cracking.shift_location("vjqtbeaweqihssi")[:a].abs
    assert_equal 5, @cracking.shift_location("vjqtbeaweqihssi")[:b].abs
    assert_equal 5, @cracking.shift_location("vjqtbeaweqihssi")[:c].abs
    assert_equal 19, @cracking.shift_location("vjqtbeaweqihssi")[:d].abs
    assert_nil @cracking.shift_location("vjqtbeaweqihssi")[:e]
  end
end
