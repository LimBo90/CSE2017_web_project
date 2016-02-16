class PagesController < ApplicationController
  def index
    @document = Document.find(params[:document_id])
  end

  def create
  end

  private
  
   def image_params
    params.require(:image).permit(:document_id,:position,:avatar)
   end

end
