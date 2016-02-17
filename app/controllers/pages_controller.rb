class PagesController < ApplicationController
  def index
    @document = Document.find(params[:document_id])
  	@commentable = @document
  	@comments = @commentable.comments
  	@comment = Comment.new
  end

  def create
  end

  def show
  	@page = Page.find(params[:id])
  	@commentable = @page
  	@comments = @commentable.comments
  	@comment = Comment.new
  end

  private
  
   def image_params
    params.require(:image).permit(:document_id,:position,:avatar)
   end

end
