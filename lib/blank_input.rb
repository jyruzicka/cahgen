class BlankInput
  def pages
    @pages ||= [[Line.new("")] * 20]
  end

  def number_of_pages
    1
  end
end