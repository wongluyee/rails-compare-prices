class HttpRequestService < ApplicationService
  def initialize(url, api_key)
    @url = url
    @api_key = api_key
  end

  def call
    uri = URI(@url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['accept'] = 'application/json'
    request['X-api-key'] = @api_key

    response = http.request(request)
    JSON.parse(response.read_body)
  end
end
