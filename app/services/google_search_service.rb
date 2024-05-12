class GoogleSearchService < ApplicationService
  def initialize(search_term)
    @search_term = search_term
  end

  def call
    api_key = (ENV['SERP_API_KEY']).to_s
    url = URI("https://serpapi.com/search.json?engine=google_play_books&q=#{@search_term}&gl=jp&api_key=#{api_key}")
    json_response = HttpRequestService.call(url)

    google_search_results = (0..2).map do |index|
      google_book_hash(json_response, index)
    end

    google_search_results
  end

  private

  def google_book_hash(json_response, index)
    {
      title:  json_response["organic_results"][0]['items'][index]['title'],
      author: json_response["organic_results"][0]['items'][index]['author'],
      link: json_response["organic_results"][0]['items'][index]['link'],
      image: json_response["organic_results"][0]['items'][index]['thumbnail'],
      price: json_response["organic_results"][0]['items'][index]['price'],
      store: "Google Play Books"
    }
  end
end
