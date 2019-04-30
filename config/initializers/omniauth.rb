Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['NOLINE_TWITTER_CONSUMER_KEY'], ENV['NOLINE_TWITTER_CONSUMER_SECRET']
end
