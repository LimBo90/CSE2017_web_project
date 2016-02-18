class DocumentsController < ApplicationController
  THUMBNAIL_WIDTH = 100
  THUMBNAIL_HEIGHT= 100

  before_action :confirm_logged_in

  def index
  	@documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
  	@document = Document.new
  end

  def create
  	@document =Document.new(document_params)
    @document.uploader = User.find(session[:user_id].to_i)
    if @document.save
      convert_to_images
    	flash[:notice] = "The Document #{@document.name} uploaded successfully."
      redirect_to(:action => 'index')
    else
    	render "new"
    end	
  end

  def edit
    @document=Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    if @document.update_attributes(document_params)
      flash[:notice] = "The Document #{@document.name} updated successfully."
      redirect_to(:action => 'index')
    else
      render "edit"
    end
  end
  
  def delete
    @document = Document.find(params[:id])
  end

  def destroy
  	@document = Document.find(params[:id])
    pages = @document.pages
    pages.each do |p|
      p.destroy
    end
  	@document.destroy
    flash[:notice] = "The Document #{@document.name} deleted successfully."
  	redirect_to(:action => 'index')
  end

  private

  def document_params
  	params.require(:document).permit(:name, :attachment, :description)
  end


  def convert_to_images
    # Convert pdf to ImageList
    @pdf = Magick::ImageList.new(@document.attachment.current_path)
    # Create Thumbnail
    thumb = @pdf[0].scale(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT)
    # Create imgs directory
    pages_directory = "#{@document.directory}/imgs"
    FileUtils.mkdir_p(pages_directory)
    # Create thumbnail
    thumb.write "#{pages_directory}/thumb.png"
    # Write each image in a file
    @pdf.each_with_index do |img, index|
      img.write("#{pages_directory}/#{index+1}.jpg")
      page = Page.new(position: index+1)
      @document.pages << page
    end
  end


  
end
