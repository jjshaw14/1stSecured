if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['BUCKETEER_AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['BUCKETEER_AWS_SECRET_ACCESS_KEY'],
      region:                ENV['BUCKETEER_AWS_REGION']
    }
    config.fog_directory  = ENV['BUCKETEER_BUCKET_NAME']
    config.fog_public     = false
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
    config.fog_authenticated_url_expiration = 600
  end
end
