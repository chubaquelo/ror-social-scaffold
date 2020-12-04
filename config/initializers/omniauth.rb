OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "rLIIlwNOwWTDDe1eDgGfLZpN4", "gGW8ikslj3zVQHqqYPKTbQ3lQ59cBTLImiU9ju0KG34yk7VTXq"
  {
    :secure_image_url => 'true',
    :image_size => 'original',
    :authorize_params => {
      :force_login => 'true',
      :lang => 'pt'
    }
  }
end