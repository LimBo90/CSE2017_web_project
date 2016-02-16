class PagesController < ApplicationController
  def index
    @document = Document.find(params[:document_id])
    convert_to_images
  end

  def create
  	@image =Image.new(image_params)

    if @image.save 
    	redirect_to(:action => 'index')
    	render "index"
    else
    	render "index"
    end	
  end

  private
  
   def image_params
    params.require(:image).permit(:document_id,:position,:avatar)
   end

end
