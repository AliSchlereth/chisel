require 'pry'

class Chisel
attr_reader :input

  def initialize(input_text)
    @input = input_text
  end

  def separate_chunks_of_text
    input
  end

end
