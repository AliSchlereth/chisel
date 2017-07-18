class Format

  def emphasis(chunk)
    if chunk.include?("*") && chunk[ (chunk.index("*") + 1) ] != " "
      emphasis_formatting(chunk)
    else
      chunk
    end
  end

  def emphasis_formatting(chunk)
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
    if chunk.include? "**"
      strong_formatting(chunk)
    else
      chunk
    end
  end

  def strong_formatting(chunk)
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
