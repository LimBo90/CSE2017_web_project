class CommentsController < ApplicationController

	before_action :confirm_logged_in
	before_action :load_commentable

	def index
		@comments = @commentable.comments
	end

	def new
		@comment = @commentable.comments.new
		
	end

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user_name = session[:username]
		@comment.user_id = session[:user_id].to_i
		if @comment.save
      	redirect_to request.referrer
    	else
      	redirect_to request.referrer , notice: "Something went wrong, please try again."
		end
	end

	def edit
		@comment = @commentable.comments.find(params[:id])
		unless authorized_user?
			flash[:notice] = "You're not authorized to  edit information of this account. Please login and try again."
      redirect_to(root_path)
		end
		session[:return_to] ||= request.referer
	end

	def update
		@comment = @commentable.comments.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:notice] = "Comment updated successfully."
      redirect_to session.delete(:return_to) #redirect to the URL where the edit request came
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
	end

	def destroy
		@comment = @commentable.comments.find(params[:id])
		if  authorized_user?
			@comment.destroy
			flash[:notice] = "Comment destroyed successfully."
      redirect_to request.referrer
		else
			flash[:notice] = "You don't have permissions to delete this comment."
      redirect_to request.referrer
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:text)
	end

	def load_commentable
		resource , id = request.path.split('/')[1,2]
		@commentable = resource.singularize.classify.constantize.find(id)
	end

	def authorized_user?
		@comment.user_id == session[:user_id]
	end

end
