require 'uri'
require 'net/http'
require 'json'
require 'cgi'

class PagesController < ApplicationController
  def search
    if params["/search"].present?
      # Get user's input
      search_term = params["/search"][:query].strip.gsub(" ", "%20")

      if contains_japanese_or_chinese?(search_term)
        search_term = encode_search_term(search_term)
      end

      search_amazon(search_term)

      # To add new book into wishlist
      @book = Book.new
    end
  end

  private

  # Check whether the search term contains Japanese or Chinese
  def contains_japanese_or_chinese?(str)
    !!str.match(/[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff66-\uff9f\u4e00-\u9fa5]/)
  end

  # Encode Japanese and/or Chinese search term to use in URI
  def encode_search_term(search_term)
    encoded_search_term = CGI.escape(search_term)
  end

  def search_amazon(search_term)
    # url = URI("https://api.listingleopard.com/single/search-page?domain=amazon.co.jp&search_term=#{search_term}%20kindle")

    # http = Net::HTTP.new(url.host, url.port)
    # http.use_ssl = true

    # request = Net::HTTP::Get.new(url)
    # request["accept"] = 'application/json'
    # request["X-api-key"] = "#{ENV['LEOPARD_LISTING_API_KEY']}"

    # response = http.request(request)
    # json_response = JSON.parse(response.read_body)

    # @title = json_response[0]['search_results'][0]['title']
    # @link = json_response[0]['search_results'][0]['link']
    # @image = json_response[0]['search_results'][0]['image']
    # @price = json_response[0]['search_results'][0]['price']['raw']

    # For view testing purpose (Free plan - 200 requests per month)
    @title = "Eloquent JavaScript"
    @link = "https://www.amazon.co.jp/Eloquent-JavaScript-3rd-Introduction-Programming-ebook/dp/B07C96Q217/ref=sr_1_1?keywords=eloquent+javascript+kindle&qid=1705379361&sr=8-1"
    @image = "https://m.media-amazon.com/images/I/81HqVRRwp3L._AC_UL320_.jpg"
    @price = "￥3,200"
  end
end
