Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ZBidrAmjyXAJVRVkY78EYg', 'DRP6DsTSPsgjYA8etFUZMUGClfXm7ImBPL6NO2HBAA'
  provider :facebook, '165661703491547', '47060611b2c892c5e9267596fbd35dc8'
  provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
