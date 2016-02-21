class LikesController < ApplicationController
before_action :load_likable

def index
	#get likes on this likable	
	@likes = @likable.likes
end


def create
#get likes on this likable
@likes = @likable.likes
#get the user id logged in 
@logged_in= session[:user_id]
		#create a new like object
		@like = @likable.likes.new
		@like.user_id = session[:user_id].to_i
		#if saved Go back to origin from new with like created
			if @like.save
				redirect_to request.referrer
			else
		#if saved Go back to origin from new with something went wrong
				redirect_to request.referrer
			end
end

def destroy
	 #@logged_in= session[:user_id]
	# @likes = @likable.likes
	# puts ":in destroy: @likable = #{@likable}"
	 #@likes.where(:user_id => @logged_in).destroy
	@likable.likes.find(params[:id]).destroy
	redirect_to request.referrer
end

private
def load_likable
resource , id = request.path.split('/')[1,2]
@likable = resource.singularize.classify.constantize.find(id)
end

def params_like
	#params.require(:like).permit()
end

end
