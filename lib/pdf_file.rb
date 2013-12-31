require "prawn"
require "prawn/measurement_extensions"

class PDFFile
  attr_accessor :input

  #-------------------------------------------------------------------------------
  # Constants for card manipulation
  CARD_WIDTH = 4.68.cm
  CARD_HEIGHT = 5.32.cm

  CARDS_ACROSS = 4
  CARDS_HIGH = 5

  A4_HEIGHT = 297.mm
  A4_WIDTH = 210.mm

  PAGE_HEIGHT = CARD_HEIGHT * CARDS_HIGH
  PAGE_WIDTH = CARD_WIDTH * CARDS_ACROSS

  MARGIN_LEFT = (A4_WIDTH - PAGE_WIDTH) / 2
  MARGIN_TOP = (A4_HEIGHT - PAGE_HEIGHT) / 2


  def initialize input
    @input = input
  end

  def render!
    @pdf = Prawn::Document.new(
      page_size: "A4",
      margin_left: MARGIN_LEFT,
      margin_right: MARGIN_LEFT,
      margin_top: MARGIN_TOP,
      margin_bottom: MARGIN_TOP
    )

    @pdf.font "Helvetica", :style => :bold
    @pdf.font_size = 12

    input.pages.each_with_index do |statements, page|
      render_card_fronts(statements)
      @pdf.start_new_page
      render_card_backs
      @pdf.start_new_page unless page == input.number_of_pages-1
    end
    @pdf.render_file("output.pdf")
  end

  # Draw a grid for the cards
  def draw_grid
      @pdf.stroke do
      #Draw vertical lines
      0.upto(4) do |i|
        @pdf.line(
          [CARD_WIDTH*i,0],
          [CARD_WIDTH*i,PAGE_HEIGHT]
        )
      end

      #Draw horizontal lines
      0.upto(5) do |i|
        @pdf.line(
          [0,          CARD_HEIGHT*i],
          [PAGE_WIDTH, CARD_HEIGHT*i]
        )
      end
    end
  end

  def box(index, &blck)
    # Determine row + column number
    column = index%4
    row = 5 - index/4

    # Margin: 10pt
    x = CARD_WIDTH * column + 10
    y = CARD_HEIGHT * row - 10

    @pdf.bounding_box([x,y], width: CARD_WIDTH-20, height: CARD_HEIGHT-20, &blck)
  end

  def render_card_fronts(statements)
    draw_grid
    statements.each_with_index do |line, idx|
      box(idx) do
        # Text
        @pdf.text line.to_s
        # Logo
        logo_size = 7.mm
        @pdf.image line.icon, fit: [logo_size,logo_size], at: [@pdf.bounds.width-logo_size,logo_size]
      end
    end
  end

  def render_card_backs
    draw_grid
  end
end