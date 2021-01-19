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
    assert_equal 8, @cracking.shift_location("vjqtbeaweqihssi")[:d].abs
    assert_nil @cracking.shift_location("vjqtbeaweqihssi")[:e]
  end

  def test_it_assigns_shifts_to_based_on_message_length
    assert_equal 27, @cracking.shift_location(" ham")[:a]
    assert_equal 27, @cracking.shift_location("f ham")[:b]
    assert_equal 27, @cracking.shift_location("lf ham")[:c]
    assert_equal 27, @cracking.shift_location("klf ham")[:d]
  end

  def test_it_can_crack
    assert_equal "hello world end", @cracking.cracking("vjqtbeaweqihssi")
  end

  def test_it_can_output_a_hash
    assert_equal "hello world end", @cracking.crack("vjqtbeaweqihssi", "291018")[:decryption]
    assert_equal "291018", @cracking.crack("vjqtbeaweqihssi", "291018")[:date]
  end
end
