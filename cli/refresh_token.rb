require 'ostruct'

class RefreshToken
  def initialize(refresh_token)
    @refresh_token = refresh_token
  end

  def fetch_new_credentials
    response = HTTParty.post(
      'https://accounts.salesloft.com/oauth/token',
      body: {
        client_id: ENV.fetch('SALESLOFT_APP_ID'),
        client_secret: ENV.fetch('SALESLOFT_APP_SECRET'),
        grant_type: 'refresh_token',
        refresh_token: @refresh_token
      }
    )
    OpenStruct.new(response)
  end
end
