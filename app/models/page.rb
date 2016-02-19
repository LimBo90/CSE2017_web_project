class Page < ActiveRecord::Base

belongs_to :document

has_many :likes, as :likable

validates :position, :presence => true

scope :sorted, lambda { order("pages.position ASC") }

 #el satren dool kano 3ashan a save image fi el database bs mgrbthomsh lsa fa msh 3aref homa sa7 wala la2
 #has_attached_file :avatar, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/pages/:style/missing.png"
  #validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/


end