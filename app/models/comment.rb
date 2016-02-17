class Comment < ActiveRecord::Base

belongs_to :user
belongs_to :commentable , polymorphic: true

		scope :newest_first , lambda {order("comments.created_at ASC")}

end
