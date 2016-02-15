class Document < ActiveRecord::Base
	
	#belongs_to :uploader, :class_name => "User"
	has_many :images
	#has_many :comments

	mount_uploader :attachment , PdfUploader

	vali

end

