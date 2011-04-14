Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ZBidrAmjyXAJVRVkY78EYg', 'DRP6DsTSPsgjYA8etFUZMUGClfXm7ImBPL6NO2HBAA'
  if ENV["RAILS_ENV"] == "production"
    provider :facebook, '165661703491547', '47060611b2c892c5e9267596fbd35dc8'
  else
    provider :facebook, '178296998887054', '06aa2735dd3aab382e224f2e3c89ea40'
  end
  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
