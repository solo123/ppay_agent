Airbrake.configure do |config|
  config.host = 'http://error.pooul.cn'
  config.project_id = true
  config.project_key = 'ea9ddc897df95cb666f32ffa27fb6588'
end if Rails.env.production?
