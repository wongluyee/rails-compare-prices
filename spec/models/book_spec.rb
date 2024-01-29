require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'book must have a title' do
    it 'return the title of the book' do
      book = Book.new(title: 'Ruby 101')
      expect(book.title).to eq('Ruby 101')
    end
  end
end
