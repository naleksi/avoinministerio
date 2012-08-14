CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => ENV["AWS_Access_Key_Id"],
    :aws_secret_access_key => ENV["AWS_Secret_Access_Key"]
  }
  config.fog_directory = ENV["AWS_Directory"]
  
  config.permissions = 0644
  
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
