class UploadExistingProfileImages < ActiveRecord::Migration
  def up
    Profile.where("image NOT NULL").all.each do |profile|
      # Bypass the profile.image accessor which is a CarrierWave uploader.
      # We need the URL which is already in the database.
      profile.remote_image_url = profile["image"]
      profile.save
    end
  end

  def down
    Profile.where("image NOT NULL").all.each do |profile|
      profile["image"] = profile.image.url
      profile.save
    end
  end
end
