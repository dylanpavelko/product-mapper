class ProfileImage < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image
  validates_attachment :image, :size => { :in => 0..100.kilobytes }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


end
