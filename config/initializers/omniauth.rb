Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, host: 'cas.tamu.edu', ssl: true, login_url: '/cas/login', logout_url: '/cas/logout', service_validate_url: '/cas/serviceValidate'
end
