class LikesController < ApplicationController
before_action :load_likable

def index
	#get likes on this likable	
	@likes = @likable.likes
	#get number of likes to display on page or document	
	@number_of_likes = @likes.size
end


def new
@like = @likable.likes.new
#save the request here for the delete action to return to the pre- new action 	
end


def create
#get likes on this likable
@likes = @likable.likes
#get the user id logged in 
@logged_in= session[:user_id]
	#find in likes the like belonging to this user ID
	#unless @likes.where(:user_id => @logged_in).empty?
		#if a like was found > redirect to delete to delete , cant like the same thing twice
		#redirect_to([@likable, @like], method: :delete)
	#	session[:return_to] ||= url_for(:back)
	#	puts "url for back #{session[:return_to]}"
	#	redirect_to [@likable, @like], method: :destroy
	#else
		#create a new like object
		@like = @likable.likes.new
		@like.user_id = session[:user_id].to_i
		#if saved Go back to origin from new with like created
			if @like.save
				redirect_to request.referrer
			else
		#if saved Go back to origin from new with something went wrong
				redirect_to request.referrer , notice: "Something went wrong, please try again."
			end
	#end	
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
