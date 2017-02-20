class BooksController < ApplicationController
  before_action :find_book, only: [:show]
  before_action :find_favorite, only: [:show]
  def index
    @supports = Supports::Book.new @book
    @books = @supports.category(params[:category]).nil? ? 
      Book.all : @supports.category(params[:category]).books
    if params[:category] && @supports.category(params[:category]).nil?
      flash[:warning] = t "not_category"
      redirect_to books_path
    end
  end

  def show
    @supports = Supports::Book.new @book
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :images, :category_id
  end

  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:warning] = t("controller.book.not_found_book")
      redirect_to books_path
    end
  end
  
  def find_favorite
    @favorite = current_user.favorite_books.find_by book_id: @book.id
  end
end
