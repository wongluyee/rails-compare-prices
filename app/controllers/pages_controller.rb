require 'uri'
require 'net/http'
require 'json'
require 'cgi'

class PagesController < ApplicationController
  def search
    return if params['/search'].nil?
    @query = params['/search'][:query]

    if @query.blank?
      flash[:alert] = "Please enter a search term."
      redirect_to root_path and return
    end

    # Get user's input
    search_term = @query.strip.gsub(' ', '%20')
    search_term = encode_search_term(search_term) if contains_japanese_or_chinese?(search_term)

    # Testing purpose
    @amazon_search_results = search_amazon(search_term)

    # @amazon_search_results = AmazonSearchService.call(search_term)
    # To add new book into wishlist we need to convert hash to book's instance
    # So that book instance can be use by simple form
    @amazon_search_results.each do |book|
      @book = Book.new(title: book[:title], author: book[:author], link: book[:link], image: book[:image], price: book[:price])
    end

    @kobo_search_results = KoboSearchService.call(search_term) || []
    @kobo_search_results.each do |book|
      @book = Book.new(title: book[:title], author: book[:author], link: book[:link], image: book[:image], price: book[:price])
    end
  end

  private

  # Check whether the search term contains Japanese or Chinese
  def contains_japanese_or_chinese?(str)
    !!str.match(/[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff66-\uff9f\u4e00-\u9fa5]/)
  end

  # Encode Japanese and/or Chinese search term to use in URI
  def encode_search_term(search_term)
    CGI.escape(search_term)
  end

  # For view testing purpose (Free plan - 200 requests per month)
  def search_amazon(search_term)
    first_book = {
      title: "Eloquent JavaScript",
      author: "Marijn Haverbeke",
      link: "https://www.amazon.co.jp/Eloquent-JavaScript-3rd-Introduction-Programming-ebook/dp/B07C96Q217/ref=sr_1_1?keywords=eloquent+javascript+kindle&qid=1705379361&sr=8-1",
      image: "https://m.media-amazon.com/images/I/81HqVRRwp3L._AC_UL320_.jpg",
      price: "￥3,200"
    }
    second_book = {
      title: "Second book",
      author: "Marijn Haverbeke",
      link: "https://www.amazon.co.jp/Eloquent-JavaScript-3rd-Introduction-Programming-ebook/dp/B07C96Q217/ref=sr_1_1?keywords=eloquent+javascript+kindle&qid=1705379361&sr=8-1",
      image: "https://m.media-amazon.com/images/I/81HqVRRwp3L._AC_UL320_.jpg",
      price: "￥2,200"
    }
    third_book = {
      title: "Third book",
      author: "Marijn Haverbeke",
      link: "https://www.amazon.co.jp/Eloquent-JavaScript-3rd-Introduction-Programming-ebook/dp/B07C96Q217/ref=sr_1_1?keywords=eloquent+javascript+kindle&qid=1705379361&sr=8-1",
      image: "https://m.media-amazon.com/images/I/81HqVRRwp3L._AC_UL320_.jpg",
      price: "￥1,200"
    }

    # To test spinner
    sleep 3

    return [first_book, second_book, third_book]
  end
end
