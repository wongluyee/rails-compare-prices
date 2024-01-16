require 'uri'
require 'net/http'

class PagesController < ApplicationController
  def search
    url = URI("https://api.listingleopard.com/single/search-page?domain=amazon.co.jp&search_term=eloquent%20ruby&category_id=2250738051")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["X-api-key"] = "#{ENV['LEOPARD_LISTING_API_KEY']}"

    response = http.request(request)
    puts response.read_body
  end
end
