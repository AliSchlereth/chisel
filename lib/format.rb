require "./lib/format_strong"
require "./lib/format_emphasis"

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
    FormatStrong.new.strong(chunk)
  end

  def self.emphasis(chunk)
    FormatEmphasis.new.emphasis(chunk)
  end

end
