Airbrake.configure do |config|
  config.api_key = '615823960960e555aa074b2db0e39fe1'
  config.host    = 'errbit.instakolik.com'
  config.port    = 80
  config.secure  = config.port == 443
end
