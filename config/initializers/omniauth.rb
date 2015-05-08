Rails.application.config.google_client_id = ENV["GOOGLE_CLIENT_ID"]
Rails.application.config.google_client_secret = ENV["GOOGLE_CLIENT_SECRET"]

OmniAuth.config.logger = Rails.logger

CLIENT_ID = Rails.application.secrets.google_client_id
CLIENT_SECRET = Rails.application.secrets.google_client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, CLIENT_ID, CLIENT_SECRET, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, scope: 'userinfo.email,calendar'}
end