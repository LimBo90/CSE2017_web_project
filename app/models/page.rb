class Page < ActiveRecord::Base

  has_many :comments , as: :commentable
  belongs_to :document

  validates :position, :presence => true
  validates_uniqueness_of :position , scope: :document_id


  scope :sorted, lambda { order("pages.position ASC") }
  before_destroy :delete_page_comments
  
  private
    
  def delete_user_comments
    self.comments.destroy_all
  end

  def link_to_image
    "#{self.document.directory}/imgs/#{self.position}.jpg"
  end

end