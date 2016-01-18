Airbrake.configure do |config|
  config.host = 'http://error.pooul.cn'
  config.project_id = true
  config.project_key = 'fe81ff2b35615e009656984060839f38'
end if Rails.env.production?
