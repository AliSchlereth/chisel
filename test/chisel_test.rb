gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/chisel'
require 'pry'

class ChiselTest <Minitest::Test

  def test_chisel_can_recognize_a_chunk_of_text
    chisel = Chisel.new("This is a single chunk of text.")
    assert_equal ["This is a single chunk of text."], chisel.input
  end

  def test_chisel_can_separate_input_into_chunks
    chisel = Chisel.new("This is the first chunk of text.\n
    This is a second chunk of text.")

    assert_equal "This is the first chunk of text.", chisel.input.first
  end

  def test_chisel_can_reformat_input_with_heading
    chisel = Chisel.new("# Heading")
    assert_equal "<h1> Heading </h1>", chisel.formatting
  end

  def test_chisel_can_reformat_input_without_heading
    chisel = Chisel.new("Paragraph")
    assert_equal "<p> Paragraph </p>", chisel.formatting
    assert_equal "<p> Paragraph </p>", chisel.input
  end

  def test_chisel_can_reformat_asterisk_to_emphasis
    chisel = Chisel.new("paragraph *with* emphasis")
    assert_equal "<p> paragraph <em> with </em> emphasis </p>", chisel.formatting
  end

  def test_chisel_can_reformat_double_asterisk_to_strong
    chisel = Chisel.new("paragraph **with** strong")
    assert_equal "<p> paragraph <strong> with </strong> strong </p>", chisel.formatting
  end

  def test_chisel_can_reformat_two_separate_strong_words
    chisel = Chisel.new("paragraph **with** strong **and** strong")
    assert_equal "<p> paragraph <strong> with </strong> strong <strong> and </strong> strong </p>", chisel.formatting
  end

  # def test_chisel_can_reformat_two_separate_emphasized_words
  #   chisel = Chisel.new("paragraph *with* emphasis *and* emphasis")
  #   assert_equal "<p> paragraph <em> with </em> emphasis <em> and </em> emphasis </p>", chisel.formatting
  # end

  def test_chisel_can_reformat_phrases_using_both_emphasize_and_strong

  end

end
