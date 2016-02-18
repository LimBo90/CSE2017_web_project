class Document < ActiveRecord::Base
	
	belongs_to :uploader, :class_name => 'User', :foreign_key => 'uploader_id'
	has_many :pages
	#has_many :comments

	mount_uploader :attachment , PdfUploader

  validates :name, presence: true,
                   length: { within: 8..25 }
  validates :attachment, presence: true
  validates :description, length: {maximum: 125}

  after_destroy :remove_folder, :remove_related_pages

  def directory
    "/documents/document #{self.id}"
  end
  
  private
  def remove_folder
    folder_location = File.dirname(self.attachment.current_path)
    FileUtils.rm_rf(folder_location)
  end

  def remove_related_pages
    self.pages.destroy_all
  end
end

