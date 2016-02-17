class Document < ActiveRecord::Base
	
	belongs_to :uploader, :class_name => 'User', :foreign_key => 'uploader_id'
	has_many :pages
	has_many :comments , as: :commentable

	mount_uploader :attachment , PdfUploader

  validates :name, presence: true,
                   length: { within: 8..25 }
  validates :attachment, presence: true
  validates :description, length: {maximum: 125}

  after_destroy :remove_folder

  def directory
    File.dirname(self.attachment.current_path)
  end
  
  private
  def remove_folder
    FileUtils.rm_rf(self.directory)
  end
end

