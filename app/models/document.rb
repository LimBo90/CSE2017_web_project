class Document < ActiveRecord::Base
	
	#belongs_to :uploader, :class_name => "User"
	has_many :images
	#has_many :comments

	mount_uploader :attachment , PdfUploader

  validates :name, presence: true,
                   length: { within: 8..25 }
  validates :attachment, presence: true
  validates :description, length: {maximum: 125}

end

