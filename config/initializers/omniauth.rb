OmniAuth.config.logger = Rails.logger

GOOGLE_CLIENT_ID = ENV["GOOGLE_CLIENT_ID"] || Rails.application.secrets.google_client_id
GOOGLE_CLIENT_SECRET = ENV["GOOGLE_CLIENT_SECRET"] || Rails.application.secrets.google_client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, scope: 'userinfo.email,calendar', access_type: 'offline',  prompt: 'consent'}
end