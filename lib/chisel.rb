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
    end.join(" ")
  end

  def body_formatting(chunk)
    if chunk.include? "#"
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
      # binding.pry
    else
      chunk
    end
  end

  def heading(chunk)
    header_size = chunk.count("#").to_s
    chunk = chunk.gsub("#", "<h" + header_size + ">")
    chunk + " </h" + header_size + ">"
  end

  def paragraph(chunk)
    "<p> " + chunk + " </p>"
  end

  def emphasis(chunk)
    chunk = chunk.split
    chunk.map do |item|
      if item.start_with?("*")
        item.sub!("*", "<em> ")
        # item.insert(0,"<em> ")
      else
        item
      end
      if item.end_with?("*")
        item.delete!("*")
        item.insert(-1," </em>")
      else
        item
      end
    end.join(" ")
  end

  def strong(chunk)
    chunk = chunk.split
    chunk.map do |item|
      if item.start_with?("**")
        item.sub!("**", "<strong> ")
        # item.insert(0,"<strong> ")
      else
        item
      end
      if item.end_with?("**")
        item.delete!("**")
      item.insert(-1," </strong>")
      else
        item
      end
    end.join(" ")
  end

end
