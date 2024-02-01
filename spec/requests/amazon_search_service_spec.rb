require 'rails_helper'

RSpec.describe AmazonSearchService, type: :service do
  subject { described_class.new('eloquent ruby') }

  describe '#initialize' do
    it 'sets the search term' do
      expect(subject.instance_variable_get(:@search_term)).to eq('eloquent ruby')
    end
  end

  describe '#call' do
    let(:mock_response) do
      [{ 'search_results' => [
        { 'title' => 'Eloquent ruby', 'link' => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', 'image' => 'image1.jpg', 'price' => { 'raw' => '10.00' } },
        { 'title' => 'Ruby on Rails', 'link' => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', 'image' => 'image2.jpg', 'price' => { 'raw' => '20.00' } },
        { 'title' => 'Ruby', 'link' => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', 'image' => 'image3.jpg', 'price' => { 'raw' => '30.00' } }
        ]
      }]
    end

    before do
      allow(HttpRequestService).to receive(:call).and_return(mock_response)
    end

    it 'returns search results' do
      results = subject.call
      expect(results).to eq([
        { :title => 'Eloquent ruby', :author => 'Russ Olsen', :link => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', :image => 'image1.jpg', :price => '10.00' },
        { :title => 'Ruby on Rails', :author => 'Russ Olsen', :link => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', :image => 'image2.jpg', :price => '20.00' },
        { :title => 'Ruby', :author => 'Russ Olsen', :link => 'https://www.amazon.co.jp/Eloquent-Ruby-Addison-Wesley-Professional/dp/0321584104', :image => 'image3.jpg', :price => '30.00' }
      ])
    end
  end
end
