class KoboSearchService < ApplicationService
  def initialize(search_term)
    @search_term = search_term
  end

  def call
    app_id = (ENV['RAKUTEN_APP_ID']).to_s
    url = URI("https://app.rakuten.co.jp/services/api/Kobo/EbookSearch/20170426?format=json&title=#{@search_term}&applicationId=#{app_id}")
    json_response = HttpRequestService.call(url)

    iterate_times = 2
    items_founded = json_response['Items'].nil? ? 0 : json_response['Items'].count
    iterate_times = items_founded - 1 if items_founded < 3 && items_founded > 0

    if items_founded > 0
      kobo_search_results = (0..iterate_times).map do |index|
        kobo_book_hash(json_response, index)
      end
    end

    kobo_search_results
  end

  private

  def kobo_book_hash(json_response, index)
    {
      title:  json_response["Items"][index]['Item']['title'],
      author: json_response["Items"][index]['Item']['author'],
      link: json_response["Items"][index]['Item']['itemUrl'],
      image: json_response["Items"][index]['Item']['largeImageUrl'],
      price: json_response["Items"][index]['Item']['itemPrice']
    }
  end
end
