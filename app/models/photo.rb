class Photo < ActiveRecord::Base
  belongs_to :model
  attr_accessible :image, :snapshot

  has_attached_file :image, 
    :styles => { :thumb => "250x250^" }, 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment  :image, :presence => true,
                        :content_type => { :content_type => "image/jpg" },
  									    :size => { :in => 0..2.megabytes }
end
