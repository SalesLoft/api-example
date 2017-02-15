class Token
  def initialize
    @store = Store.new
  end

  def access_token
    @store.transaction do
      expires_at = Time.at(@store.expires_at)

      if expired?(expires_at) && new_credentials.access_token
        @store.token = new_credentials.access_token
        @store.refresh_token = new_credentials.refresh_token
        @store.expires_at = Time.now.to_i + new_credentials.expires_in
      end

      @store.token
    end
  end

  def headers
    {
      Authorization: "Bearer #{access_token}"
    }
  end

  private

  def expired?(date)
    Time.now > date
  end

  def new_credentials
    @new_credentials ||= RefreshToken.new(@store.refresh_token).fetch_new_credentials
  end
end
