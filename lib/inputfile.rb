class Line
  attr_accessor :to_s, :icon

  def initialize l
    if l =~ /#(\S+)$/
      raw_icon = $1
      @icon = Dir["./icons/#{raw_icon}.*"][0]
      @to_s = $`.strip
    else
      @to_s = l
    end
    @to_s.gsub!("\\","\n")
  end

  def icon
    "./icons/default.png"
  end
end

# Represents a file, newline-separated. Read it in, it'll parse everything, then
# use #each or #[] to get lines.
class InputFile
  attr_accessor :lines

  def initialize contents
    @lines = contents.split("\n").map{ |l| Line.new(l) }
  end

  def self.from_file file
    new(File.read(file))
  end

  def self.from_stdin
    new($stdin.read)
  end

  def number_of_pages
    @number_of_pages ||= (@lines.size / 20.0).ceil
  end

  # Divide our lines into groups of 20, for each page
  def pages
    pages_array = []
    0.upto(number_of_pages - 1) do |i|
      pages_array << @lines[i*20,20]
    end
    pages_array
  end

  def method_missing(sym, *args)
    if @lines.respond_to? sym
      @lines.send(sym,*args)
    end
  end
end