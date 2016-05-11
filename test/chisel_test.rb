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
    chisel = Chisel.new("## Heading")
    assert_equal "<h2> Heading </h2>", chisel.formatting
  end

  def test_chisel_will_not_reformat_to_heading_without_space_between_pound_and_text
    chisel = Chisel.new("#Heading")
    assert_equal "<p> #Heading </p>", chisel.formatting
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

  def test_chisel_can_reformat_two_separate_emphasized_words
    chisel = Chisel.new("paragraph *with* emphasis *and* emphasis")
    assert_equal "<p> paragraph <em> with </em> emphasis <em> and </em> emphasis </p>", chisel.formatting
  end

  def test_chisel_can_reformat_phrases_using_emphasize
    chisel = Chisel.new("paragraph *with a phrase* emphasized")
    assert_equal "<p> paragraph <em> with a phrase </em> emphasized </p>", chisel.formatting
  end

  def test_chisel_can_reformat_phrase_using_strong
    chisel = Chisel.new("paragraph **with a phrase** stronged")
    assert_equal "<p> paragraph <strong> with a phrase </strong> stronged </p>", chisel.formatting
  end

  def test_chisel_can_reformat_a_phrase_using_emphasis_and_strong
    chisel = Chisel.new("paragraph *with a **strong** phrase* emphasized")
    assert_equal "<p> paragraph <em> with a <strong> strong </strong> phrase </em> emphasized </p>", chisel.formatting
  end

  def test_chisel_does_not_reformat_a_word_with_single_asterisk_mid_word
    chisel = Chisel.new("paragraph wi*th mis placed asterisk")
    assert_equal "<p> paragraph wi*th mis placed asterisk </p>", chisel.formatting
  end

  def test_chisel_does_not_translate_open_strong_without_closed_strong
    chisel = Chisel.new("paragraph with mis**placed strong")
    assert_equal "<p> paragraph with mis**placed strong </p>", chisel.formatting
  end

  def test_chisel_does_not_reformat_asterisks_without_full_set_strong
    chisel = Chisel.new("paragraph **with** one full and one **half strong")
    assert_equal "<p> paragraph <strong> with </strong> one full and one **half strong </p>", chisel.formatting
  end

end
