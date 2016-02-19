class LikesController < ApplicationController
before_filter :load_likable

def index
	@likes = @likable.likes
	@number_of_likes = @likes.size
end

def new
	 
	if @likes.find_by user_id: session[:user_id]
		redircet_to(:action => delete)
	else
	@like = Like.new(params_like)
	@like.save
	redircet_to @likable, notice: "like created."
end

def delete
	@likes.find_by {user_id: session[:user_id]}.destroy
end


private
def load_likable
resource, id = request.path.split('/'[1,2])
@likable = resource.singularize.classify.constantize.find(id)
end

def params_like
	params.require(:like).permit(:likable,:likable_id,:user_id)
end

end
