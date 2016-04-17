require 'pry'

class Chisel
attr_reader :input

  def initialize(input_text)
    @input = input_text.split("\n")
  end

  def formatting
    input.map do |chunk|
      if chunk.include? "#"
        heading(chunk)
      else
        paragraph(chunk)
      end
    end.join
  end

  def heading(chunk)
    header_size = chunk.count("#").to_s
    chunk = chunk.gsub("#", "<h" + header_size + ">")
    chunk + " </h" + header_size + ">"
  end

  def paragraph(chunk)
    "<p> " + chunk + " </p>"
  end
end
