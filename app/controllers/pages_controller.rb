class PagesController < ApplicationController
   
  before_action :confirm_logged_in
  before_action :find_document

  def index
    @pages = @document.pages 
  end

  def show
    @page = Page.find(params[:id])
    @next_page = @document.pages.find_by_position(@page.position + 1)
    @previous_page =  @document.pages.find_by_position(@page.position - 1)
  end

  private
   def find_document
      if params[:document_id]
        @document = Document.find(params[:document_id])
      end
    end

end