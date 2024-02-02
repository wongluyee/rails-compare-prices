require 'rails_helper'

RSpec.describe KoboSearchService, type: :service do
  subject { described_class.new('eloquent ruby') }

  describe '#initialize' do
    it 'sets the search term' do
      expect(subject.instance_variable_get(:@search_term)).to eq('eloquent ruby')
    end
  end

  describe '#call' do
    let(:mock_response) do
      {
        'Items' => [
          { 'Item' => { 'title' => 'Eloquent Ruby', 'author' => 'Russ Olsen', 'itemUrl' => 'www.item-url1.com', 'mediumImageUrl' => 'image url 1', 'itemPrice' => 10.0} },
          { 'Item' => { 'title' => 'Eloquent Ruby', 'author' => 'Russ Olsen', 'itemUrl' => 'www.item-url2.com', 'mediumImageUrl' => 'image url 2', 'itemPrice' => 20.0} },
          { 'Item' => { 'title' => 'Eloquent Ruby', 'author' => 'Russ Olsen', 'itemUrl' => 'www.item-url3.com', 'mediumImageUrl' => 'image url 3', 'itemPrice' => 30.0} }
        ]
      }
    end

    before do
      allow(HttpRequestService).to receive(:call).and_return(mock_response)
    end

    it 'returns search results' do
      results = subject.call
      expect(results).to eq([
        { :title => 'Eloquent Ruby', :author => 'Russ Olsen', :link => 'www.item-url1.com', :image => 'image url 1', :price => 10.0},
        { :title => 'Eloquent Ruby', :author => 'Russ Olsen', :link => 'www.item-url2.com', :image => 'image url 2', :price => 20.0},
        { :title => 'Eloquent Ruby', :author => 'Russ Olsen', :link => 'www.item-url3.com', :image => 'image url 3', :price => 30.0}
      ])
    end
  end
end
