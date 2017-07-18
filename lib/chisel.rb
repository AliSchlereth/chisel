require 'pry'
require './lib/format'

class Chisel
attr_reader :input

  def initialize(input_text)
    @input = input_text.split("\n\n")
  end

  def formatting
    @input = input.map do |chunk|
      # chunk = body_formatting(chunk)
      chunk = Format.body(chunk)
      chunk = Format.strong(chunk)
      chunk = Format.emphasis(chunk)
      chunk = list_formatting(chunk)
    end.join(" ")
  end

  def print_output
    print @input
  end

  def list_formatting(chunk)
    if chunk.include? "* "
      unordered_list(chunk)
    elsif
      chunk.include? ("1.")
      # if chunk contains an integer followed by a period
      # it passes through to ordered_list
      # are any of the characters an integer

      # (0..9).to_a.any? do |num|
      # chunk.include?(num.to_s)
      # binding.pry
      # end

      ordered_list(chunk)
    else
      chunk
    end
  end

  def unordered_list(chunk)
    chunk = chunk.split
    index = chunk.index("*")
    paragraph = chunk.shift(index)
    paragraph.push("</p>")
    paragraph = paragraph.join(" ")
    chunk.pop
    chunk.unshift("<ul>")
    @counter = 0
    chunk.map do |item|
      if item == "*" && @counter < 1
        item.gsub!("*", "<li>")
        @counter =+ 1
      elsif
        item == "*" && @counter >= 1
        item.gsub!("*", "</li> <li>")
        @counter += 1
      else
        item
      end
    end
    chunk.insert(-1, "</li>")
    chunk.insert(-1, "</ul>")
    chunk.unshift(paragraph)
  end

  def ordered_list(chunk)
    chunk = chunk.split
    number_index = chunk.index("1.")
    paragraph = chunk.shift(number_index)
    paragraph.push("</p>")
    paragraph = paragraph.join(" ")
    chunk.pop
    chunk.unshift("<ol>")
    @counter = 0
    chunk.map do |item|
      if item == "1." && @counter < 1
        item.gsub!("1.", "<li>")
        @counter += 1
      elsif
        item == "1." && @counter >= 1
        item.gsub!("1.", "</li> <li>")
        @counter += 1
      else
        item
      end
    end
    chunk.insert(-1, "</li>")
    chunk.insert(-1, "</ol>")
    chunk.unshift(paragraph)
  end


end
