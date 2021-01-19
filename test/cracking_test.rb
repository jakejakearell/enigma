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
  end

  def test_expected_ordinal_values_of_orginal_message
    assert_equal [26, 4, 13, 3]
  end

  def test_it_can_figure_out_the_location_of_shifts
    assert_equal "hello world end", @cracking.shift_location("vjqtbeaweqihssi")
  end
end
