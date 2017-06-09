class SimpleApi
  BASE_URI = 'api.salesloft.com'
  include HTTParty
  base_uri BASE_URI

  def initialize(base: '/public_api/v1', token:)
    @base = base
    @token = token
  end

  def me
    self.class.get(url('me.json'), headers: @token.headers).parsed_response
  end

  # Don't submit to .json if you're using the email as the identifier
  def get_person(id)
    self.class.get(url("people/#{id}"), headers: @token.headers).parsed_response
  end

  def create_person(data)
    self.class.post(url('people.json'), headers: @token.headers, body: data).parsed_response
  end

  def update_person(id, data)
    self.class.put(url("people/#{id}.json"), headers: @token.headers, body: data).parsed_response
  end

  def person_url(id)
    "https://#{BASE_URI}/app/people/#{id}"
  end

  def cadences
    self.class.get(url("cadences.json"), headers: @token.headers).parsed_response
  end

  def add_person_to_cadence(person_id, cadence_id)
    self.class.post(url("people/#{person_id}/cadence_memberships.json"), headers: @token.headers, body: { cadence_id: cadence_id }).parsed_response
  end

  def cadence_people_url(cadence_id)
    "https://#{BASE_URI}/app/cadences_v2/#{cadence_id}/v2/cadence_people"
  end

  private

  def url(path)
    "#{@base}/#{path}"
  end
end
