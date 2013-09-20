Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :cas, host: 'cas.tamu.edu', ssl: true, login_url: '/cas/login', logout_url: '/cas/logout', service_validate_url: '/cas/serviceValidate'
  else
    provider :cas, host: 'cas-dev.tamu.edu', ssl: true, login_url: '/cas/login', logout_url: '/cas/logout', service_validate_url: '/cas/serviceValidate'
  end
end
