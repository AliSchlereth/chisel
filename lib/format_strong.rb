class FormatStrong

  def strong(chunk)
    if chunk.include? "**"
      translate_strong(chunk)
    else
      chunk
    end
  end

  def translate_strong(chunk)
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



end
