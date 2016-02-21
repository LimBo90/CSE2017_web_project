class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :likable , polymorphic: true
	validates_uniqueness_of :likable_id , scope: :user_id
end
