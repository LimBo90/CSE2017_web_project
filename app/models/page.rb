class Page < ActiveRecord::Base

  has_many :comments , as: :commentable
  belongs_to :document
  has_many :likes , as: :likable

  validates :position, :presence => true
  validates_uniqueness_of :position , scope: :document_id


  scope :sorted, lambda { order("pages.position ASC") }
  before_destroy :delete_page_comments, :delete_page_likes
  
  private
    
  def delete_page_comments
    self.comments.destroy_all
  end

  def delete_page_likes
    self.likes.destroy_all
  end

  def link_to_image
    "#{self.document.directory}/imgs/#{self.position}.jpg"
  end

end
