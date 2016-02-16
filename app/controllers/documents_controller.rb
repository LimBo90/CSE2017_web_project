class DocumentsController < ApplicationController
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
    if @document.save 
    	flash[:notice] = "The Document #{@document.name} uploaded successfully."
    	redirect_to(:action => 'index')
      #convert_to_images
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
      #convert_to_images
    else
      render "edit"
    end
  end
  
  def delete
    @document = Document.find(params[:id])
  end

  def destroy
  	@document = Document.find(params[:id])

  	@document.destroy
    flash[:notice] = "The Document #{@document.name} deleted successfully."
  	redirect_to(:action => 'index')
    #TODO: delete file from application
  end

  private

  def document_params
  	params.require(:document).permit(:name, :attachment, :description)
  end

  #def convert_to_images
    #pdf_array = Grim.reap("#{Rails.root}/public/uploads/document #{@document.id}")      # returns Grim::Pdf instance for pdf
    #position = 1               # returns the number of pages in the pdf
    #pdf_array.each do |p|
      #p.save("#{Rails.root}/public/saved_images/#{@document.name}/#{position}.png")
     # Page.new(:document_id => @document.id , :position => position , :avatar => p)
      #Page.save
     # redirect_to(:controller => 'pages',:action => 'create', 
      #  :document_id => @document.id , :position => position , :avatar => page)
    #position +=1 
   #end
  #end
end
