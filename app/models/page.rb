class Page < ActiveRecord::Base

has_many :comments , as: :commentable
belongs_to :document

validates :position, :presence => true

scope :sorted, lambda { order("pages.position ASC") }
before_destroy :delete_page_comments
  
  private
  	
  def delete_user_comments
    self.comments.destroy_all
  end

end