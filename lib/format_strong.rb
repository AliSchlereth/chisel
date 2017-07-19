
module FormatStrong

  def self.strong(chunk)
    if chunk.include? "**"
      strong_formatting(chunk)
    else
      chunk
    end
  end

  def self.strong_formatting(chunk)
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

end
