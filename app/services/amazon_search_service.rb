class AmazonSearchService < ApplicationService
  def initialize(search_term)
    @search_term = search_term
  end

  def call
    url = URI("https://api.listingleopard.com/single/search-page?domain=amazon.co.jp&search_term=#{@search_term}%20kindle")
    api_key = (ENV['LEOPARD_LISTING_API_KEY']).to_s
    json_response = send_request(url, api_key)

    amazon_search_results = (0..2).map do |index|
      amazon_book_hash(json_response, index)
    end

    return amazon_search_results
  end

  private

  def send_request(url, api_key)
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['accept'] = 'application/json'
    request['X-api-key'] = api_key

    response = http.request(request)
    JSON.parse(response.read_body)
  end

  def amazon_book_hash(json_response, index)
    {
      title: json_response[0]['search_results'][index]['title'],
      link: json_response[0]['search_results'][index]['link'],
      image: json_response[0]['search_results'][index]['image'],
      price: json_response[0]['search_results'][index]['price']['raw']
    }
  end
end
