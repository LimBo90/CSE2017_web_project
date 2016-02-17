class PagesController < ApplicationController
  def index
    @document = Document.find(params[:document_id])
    @pages = @document.pages.sorted
  end

  def show
    @document = Document.find(params[:document_id])
    @page = Page.find(params[:id])
    @next_page = @document.pages.sorted[@page.position + 1]
    @previous_page = @document.pages.sorted[@page.position - 1]
  end

  private
  
   def image_params
    params.require(:image).permit(:document_id,:position,:avatar)
   end

end
