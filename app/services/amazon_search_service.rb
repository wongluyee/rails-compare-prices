require 'open-uri'
require 'nokogiri'

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

    amazon_search_results
  end

  private

  def amazon_book_hash(json_response, index)
    {
      title: json_response[0]['search_results'][index]['title'],
      author: scrape_author(json_response[0]['search_results'][index]['link']),
      link: json_response[0]['search_results'][index]['link'],
      image: json_response[0]['search_results'][index]['image'],
      price: json_response[0]['search_results'][index]['price']['raw']
    }
  end

  def scrape_author(link)
    attempts = 0
    begin
      url = link

      html_file = URI.open(url).read
      html_doc = Nokogiri::HTML.parse(html_file)

      author = html_doc.search(".author a").text
    rescue OpenURI::HTTPError => error
      puts "Error accessing #{url}: #{error}. Retrying..."
      attempts += 1
      retry if attempts < 5
      puts "Failed to access #{url} after 5 attempts."
    end
  end
end
