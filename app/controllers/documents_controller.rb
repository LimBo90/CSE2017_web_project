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
      convert_to_images_docsplit
      #flash[:notice] = "The Document #{@document.name} uploaded successfully."
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
    pdf_reading_time = Benchmark.realtime do
      @pdf = Magick::ImageList.new(@document.attachment.current_path)
    end

    # Create imgs directory
    document_folder_location = File.dirname(@document.attachment.current_path)
    images_directory = "#{document_folder_location}/imgs"
    FileUtils.mkdir_p(images_directory)

    images_writing_time = Benchmark.realtime do
      # Create and save Thumbnail
      thumb = @pdf[0].scale(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT)
      thumb.write "#{images_directory}/thumb.png"
      # Write each image in a file
      @pdf.each_with_index do |img, index|
        img.write("#{images_directory}/#{index + 1}.jpg")
        page = Page.new(position: index + 1)
        @document.pages << page
      end
    end
    append_notice("rmagick_extracting_time = #{images_writing_time + pdf_reading_time} seconds")
  end

  def convert_to_images_docsplit
    document_folder_location = File.dirname(@document.attachment.current_path)
    images_directory = "#{document_folder_location}/imgs"
    FileUtils.mkdir_p(images_directory)

    extracting_time = Benchmark.realtime do
      Docsplit.extract_images(@document.attachment.current_path, format: [:jpg], output: images_directory)
    end
    append_notice "docsplit_extracting_time = #{extracting_time} seconds"
  end

  def append_notice(notice)
    if flash[:notice]
      flash[:notice] = flash[:notice] + ' | ' + notice
    else
      flash[:notice] = notice
    end
  end
end
