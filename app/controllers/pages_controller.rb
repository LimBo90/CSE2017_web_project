class PagesController < ApplicationController

  RESULTS_PER_PAGE = 10

  before_action :confirm_logged_in
  before_action :find_document
  def index
    @commentable = @document
    @comments = @commentable.comments
    @comment = Comment.new
    @pages = Page.where(:document_id => @document.id).paginate(:page => params[:page],:per_page => RESULTS_PER_PAGE)
    generate_thumbs
  end

  def show
    @page = Page.find(params[:id])
    load_image
    @next_page = @document.pages.find_by_position(@page.position + 1)
    @previous_page =  @document.pages.find_by_position(@page.position - 1)
    @commentable = @page
    @comments = @commentable.comments
    @comment = Comment.new
  end
  
  private
   def find_document
      if params[:document_id]
        @document = Document.find(params[:document_id])
      end
    end

  def load_image
    image = Magick::Image.read(@document.attachment.current_path + "[#{@page.position}]")[0]
    image_path = File.dirname(@document.attachment.current_path) + "/tmp.png"
    image.write(image_path)
  end

    def generate_thumbs
      thumb_path = File.dirname(@document.attachment.current_path)+'/thumbs'
      FileUtils.mkdir_p(thumb_path)
      params[:page] ||= 1

    # (1..@pages.size).each do |index|
    #   params[:page] ||= 1
    #   page_number = RESULTS_PER_PAGE * (params[:page].to_i - 1) + index - 1
    #   puts "page_number = #{page_number} | page=#{params[:page]}"
    #   thumb = Magick::Image.read(@document.attachment.current_path + "[#{page_number}]").first.resize!(200,200)
    #   thumb.write(thumb_path + "/#{index}.jpg")
    #   end

    RGhost::Convert.new(@document.attachment.current_path).to :jpg, :multipage => true, :range => @pages.first.position..@pages.first.position+9,
                                                                      :resolution => 100, :filename => "#{thumb_path+'/thumb.jpg'}"

    end
end

