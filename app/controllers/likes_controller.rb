class LikesController < ApplicationController
before_filter :load_likable
private
def load_likable
resource, id = request.path.split('/'[1,2])
@likable = resource.singularize.classify.constantize.find(id)
end
end
