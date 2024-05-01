class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to books_path, notice: "Added to wishlist"
    else
      render :new, status: :unprocessable_entity, alert: "Failed to add to wishlist"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
     params.require(:book).permit(:title, :author, :link, :image, :price)
  end
end
