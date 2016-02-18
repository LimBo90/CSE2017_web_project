class PagesController < ApplicationController
   
  before_action :confirm_logged_in
  before_action :find_document

  def index
    @pages = @document.pages 
  end

  def create
  end

  def show
  	@page = Page.find_by_position(params[:position])
  end

  private
  
   def image_params
    params.require(:image).permit(:document_id,:position)
   end

   def find_document
      if params[:document_id]
        @document = Document.find(params[:document_id])
      end
    end

end
