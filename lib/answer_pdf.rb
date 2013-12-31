require_relative "pdf_file"

class AnswerPDF < PDFFile
  def render_card_backs
    # draw_grid
    font_size_buffer = @pdf.font_size
    @pdf.font_size = 64
    0.upto(19) do |i|
      box(i) do
        @pdf.text("!", align: :center, valign: :center)
      end
    end
    @pdf.font_size = font_size_buffer
  end
end