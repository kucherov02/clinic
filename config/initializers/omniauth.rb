Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '89722091150-sbqaqjf9c3bir88nj7b0tem5crc4q7nk.apps.googleusercontent.com', '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'
end
