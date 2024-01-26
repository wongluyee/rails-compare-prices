class AmazonSearchService < ApplicationService
  def initialize(search_term)
    @search_term = search_term
  end

  def call
    url = URI("https://api.listingleopard.com/single/search-page?domain=amazon.co.jp&search_term=#{@search_term}%20kindle")
    api_key = (ENV['LEOPARD_LISTING_API_KEY']).to_s
    json_response = HttpRequestService.call(url, api_key)

    amazon_search_results = (0..2).map do |index|
      amazon_book_hash(json_response, index)
    end

    return amazon_search_results
  end

  private

  def amazon_book_hash(json_response, index)
    {
      title: json_response[0]['search_results'][index]['title'],
      author: json_response[0]['search_results'][index]['author'],
      link: json_response[0]['search_results'][index]['link'],
      image: json_response[0]['search_results'][index]['image'],
      price: json_response[0]['search_results'][index]['price']['raw']
    }
  end
end
