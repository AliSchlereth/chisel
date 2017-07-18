require "./lib/format_strong"

class Format

  attr_reader :strong_formatter


  def initialize
    @strong_formatter = FormatStrong.new
  end

  def self.body(chunk)
    if chunk.include? "# "
      heading(chunk)
    else
      paragraph(chunk)
    end
  end

  def self.heading(chunk)
    header_size = chunk.count("#").to_s
    chunk = chunk.squeeze("#")
    chunk = chunk.gsub("#", "<h" + header_size + ">")
    chunk + " </h" + header_size + ">"
  end

  def self.paragraph(chunk)
    "<p> " + chunk + " </p>"
  end

  def self.emphasis(chunk)
    if chunk.include?("*") && chunk[ (chunk.index("*") + 1) ] != " "
      translate_emphasis(chunk)
    else
      chunk
    end
  end

  def self.translate_emphasis(chunk)
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

  def self.emphasis_remainder(chunk)
    @emphasis_remainder = chunk.count("*") % 2
  end

  def self.emphasis_count(chunk)
    @emphasis_count = chunk.count("*")
  end

  def self.emphasis_start(item)
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

  def self.emphasis_end(item)
    if item.end_with?("*") && @counter < @emphasis_count - @emphasis_remainder
      @counter += 1
      item.delete!("*")
      item.insert(-1," </em>")
    else
      item
    end
  end



end
