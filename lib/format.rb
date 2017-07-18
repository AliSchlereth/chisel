class Format

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

  def self.strong(chunk)
    if chunk.include? "**"
      translate_strong(chunk)
    else
      chunk
    end
  end

  def self.translate_strong(chunk)
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

  def self.strong_remainder(chunk)
    @strong_remainder = chunk.count("*") % 4
  end

  def self.strong_count(chunk)
    @strong_count = chunk.count("**")
  end

  def self.strong_start(item)
    if item.start_with?("**") && @counter < @strong_count - @strong_remainder
      @counter += 2
      item.sub!("**", "<strong> ")
    else
      item
    end
  end

  def self.strong_end(item)
    if item.end_with?("**") && @counter < @strong_count - @strong_remainder
      @counter += 2
      item.delete!("**")
    item.insert(-1," </strong>")
    else
      item
    end
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
