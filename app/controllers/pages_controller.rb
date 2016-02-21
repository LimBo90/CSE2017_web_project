class PagesController < ApplicationController
   
  before_action :confirm_logged_in
  before_action :find_document

  def index
    @pages = Page.where(:document_id => @document.id).paginate(:page => params[:page],:per_page => 10)
    @commentable = @document
    @comments = @commentable.comments
    @comment = Comment.new
    @likable = @document
    @likes = @likable.likes
    @like = Like.new
  end

  def show
    @page = Page.find(params[:id])
    @next_page = @document.pages.find_by_position(@page.position + 1)
    @previous_page =  @document.pages.find_by_position(@page.position - 1)
    @commentable = @page
    @comments = @commentable.comments
    @comment = Comment.new
    @likable = @page
    @likes = @likable.likes
    @like = Like.new
  end
  
  private
   def find_document
      if params[:document_id]
        @document = Document.find(params[:document_id])
      end
    end
end
