class CommentsController < ApplicationController

	before_action :confirm_logged_in,

	def index
		@comments = Comment.newest_first
	end

	def show
	end

	def new
		@comment = Comment.new
		
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.user_name = session[:username]
		@comment.user_id = session[:user_id].to_i
		#@comment.page_id = Page.find(params[:id])
		if @comment.save
      	redirect_to('/comments/index')
    	else
      	redirect_to('/comments/new')
		end
	end

	def delete
	end

	private
	def comment_params
		params.require(:comment).permit(:text)
	end


end
