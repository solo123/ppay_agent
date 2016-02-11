if Rails.env == 'production'
  Airbrake.configure do |config|
    config.host = 'http://error.pooul.cn'
    config.project_id = true
    config.project_key = 'cbdd7e8cb098b92e9e461c38ca63b008'
  end
else
  Airbrake.configure do |config|
    config.host = 'http://127.0.0.1'
    config.project_id = true
    config.project_key = 'cbdd7e8cb098b92e9e461c38ca63b008'
  end
end
