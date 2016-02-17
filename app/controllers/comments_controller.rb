class CommentsController < ApplicationController

	before_action :confirm_logged_in
	before_action :load_commentable

	def index
		@comments = @commentable.comments
	end

	def show
	end

	def new
		@comment = @commentable.comments.new
		
	end

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user_name = session[:username]
		@comment.user_id = session[:user_id].to_i
		if @comment.save
      	redirect_to @commentable
    	else
      	redirect_to @commentable , notice: "Something went wrong please try again"
		end
	end

	def delete
	end

	private
	def comment_params
		params.require(:comment).permit(:text)
	end
	def load_commentable
		resource , id = request.path.split('/')[1,2]
		@commentable = resource.singularize.classify.constantize.find(id)
	end


end
