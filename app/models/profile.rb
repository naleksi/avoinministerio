require "carrierwave/orm/activerecord"

class Profile < ActiveRecord::Base
  belongs_to :citizen

  attr_accessible :first_name, :last_name, :image, :receive_newsletter,
    :receive_other_announcements, :receive_weekletter, :first_names,
    :accept_science, :accept_terms_of_use, :remote_image_url
  
  validates :first_names, :first_name, :last_name, :presence => true
  
  mount_uploader :image, ProfileImageUploader
  
  def name
    "#{first_name} #{last_name}"
  end
end
