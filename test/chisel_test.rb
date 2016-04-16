gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/chisel'
require 'pry'

class ChiselTest <Minitest::Test

  def test_chisel_can_recognize_a_chunk_of_text
    chisel = Chisel.new("This is a single chunk of text.")
    assert_equal "This is a single chunk of text.", chisel.input
  end

  def test_chisel_can_separate_input_into_chunks
    chisel = Chisel.new("This is the first chunk of text.\n
    This is a second chunk of text.")

    assert_equal "This is a first chunk of text.", chisel.
  end

end
