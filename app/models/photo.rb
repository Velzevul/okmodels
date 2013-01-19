class Photo < ActiveRecord::Base
  belongs_to :model
  attr_accessible :image, :snapshot

  has_attached_file :image, 
    :styles => { :thumb => "150x130>" }, 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates :image, :attachment_presence => true
end
