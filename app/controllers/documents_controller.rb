class DocumentsController < ApplicationController
  THUMBNAIL_WIDTH = 100
  THUMBNAIL_HEIGHT= 100

  before_action :confirm_logged_in
  after_action :create_thumbnail, only: [:create]

  def index
    @documents = Document.all.paginate(:page => params[:page],:per_page => 10)
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
    	flash[:notice] = "The Document #{@document.name} uploaded successfully."
      redirect_to(:action => 'index')
    else
    	render "new"
    end	
  end

  def edit
    @document=Document.find(params[:id])
    unless authorized_user?
      flash[:notice] = "You're not authorized to  edit this document #{@document.name}."
      redirect_to(root_path)
    end
  end

  def update
    @document = Document.find(params[:id])
    if !authorized_user?
      flash[:notice] = "You're not authorized to  update this document #{@document.name}."
      redirect_to(root_path)
    elsif @document.update_attributes(document_params)
      flash[:notice] = "The Document #{@document.name} updated successfully."
      redirect_to(:action => 'index')
    else
      render "edit"
    end
  end

  def destroy
  	@document = Document.find(params[:id])
    unless authorized_user?
      flash[:notice] = "You're not authorized to  delete this document."
      redirect_to(root_path)
    else
      pages = @document.pages
      pages.each do |p|
        p.destroy
      end
      @document.destroy
      flash[:notice] = "The Document #{@document.name} deleted successfully."
      redirect_to request.referrer
    end
  end

  private

  def document_params
  	params.require(:document).permit(:name, :attachment, :description)
  end

  def authorized_user?
    @document.uploader.id == session[:user_id]
  end

  def create_thumbnail
    thumb = Magick::Image.read(@document.attachment.current_path + "[0]")[0]
    thumb_path = File.dirname(@document.attachment.current_path) + "/thumb.png"
    thumb.write(thumb_path)
  end

end
