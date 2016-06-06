require 'pry'

class Chisel
attr_reader :input

  def initialize(input_text)
    @input = input_text.split("\n")
  end

  def formatting
    @input = input.map do |chunk|
      chunk = body_formatting(chunk)
      chunk = strong_formatting(chunk)
      chunk = emphasis_formatting(chunk)
      chunk = list_formatting(chunk)
    end.join(" ")
  end

  def body_formatting(chunk)
    if chunk.include? "# "
      heading(chunk)
    else
      paragraph(chunk)
    end
  end

  def emphasis_formatting(chunk)
    if chunk.include?("*")
      emphasis(chunk)
    else
      chunk
    end
  end

  def strong_formatting(chunk)
    if chunk.include? "**"
      strong(chunk)
    else
      chunk
    end
  end

  def list_formatting(chunk)
    if chunk.include? "* "
      unordered_list(chunk)
    elsif
      # if chunk contains an integer followed by a period
      # it passes through to ordered_list
      # are any of the characters an integer? 
      chunk = chunk.split
      chunk.any? do |item|
        item.is_a? Integer
        ordered_list(chunk)
      end
    else
      chunk
    end
  end

  def heading(chunk)
    header_size = chunk.count("#").to_s
    chunk = chunk.squeeze("#")
    chunk = chunk.gsub("#", "<h" + header_size + ">")
    chunk + " </h" + header_size + ">"
  end

  def paragraph(chunk)
    "<p> " + chunk + " </p>"
  end


  def emphasis(chunk)
    emphasis_remainder(chunk)
    emphasis_count(chunk)
    @counter = 0
    if chunk.count("*") >= 2
      chunk = chunk.split
      chunk.map do |item|
        emphasis_start(item)
        emphasis_end(item)
      end.join(" ")
    else
      chunk
    end
  end

  def emphasis_remainder(chunk)
    @emphasis_remainder = chunk.count("*") % 2
  end

  def emphasis_count(chunk)
    @emphasis_count = chunk.count("*")
  end

  def emphasis_start(item)
    if item.include?("*") && item[ (item.index("*") + 1) ] == "*"
      item
    elsif item.start_with?("*") && @counter < @emphasis_count - @emphasis_remainder
      @counter += 1
      item.sub!("*", "<em> ")
      # item.insert(0,"<em> ")
    else
      item
    end
  end

  def emphasis_end(item)
    if item.end_with?("*") && @counter < @emphasis_count - @emphasis_remainder
      @counter += 1
      item.delete!("*")
      item.insert(-1," </em>")
    else
      item
    end
  end

  def strong(chunk)
    strong_remainder(chunk)
    strong_count(chunk)
    @counter = 0
    if @strong_count >= 4
      chunk = chunk.split
      chunk.map do |item|
        strong_start(item)
        strong_end(item)
      end.join(" ")
    else
      chunk
    end
  end

  def strong_remainder(chunk)
    @strong_remainder = chunk.count("*") % 4
  end

  def strong_count(chunk)
    @strong_count = chunk.count("**")
  end

  def strong_start(item)
    if item.start_with?("**") && @counter < @strong_count - @strong_remainder
      @counter += 2
      item.sub!("**", "<strong> ")
    else
      item
    end
  end

  def strong_end(item)
    if item.end_with?("**") && @counter < @strong_count - @strong_remainder
      @counter += 2
      item.delete!("**")
    item.insert(-1," </strong>")
    else
      item
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
    chunk.map do |item|
      if item == "*"
        item.gsub!("*", "<li>")
      else
        item
      end
    end
    chunk.insert(-1, "</li>")
    chunk.insert(-1, "</ul>")
    chunk.unshift(paragraph)
  end

  def ordered_list(chunk)
    # chunk = chunk.split
    index = chunk.index(1..9)
    binding.pry
    paragraph = chunk.shift(index)
    paragraph.push("</p>")
    paragraph = paragraph.join(" ")
    chunk.pop
    chunk.unshift("<ul>")
    chunk.map do |item|
      if item == "*"
        item.gsub!("*", "<li>")
      else
        item
      end
    end
    chunk.insert(-1, "</li>")
    chunk.insert(-1, "</ul>")
    chunk.unshift(paragraph)
  end


end
