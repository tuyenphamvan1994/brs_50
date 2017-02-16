class BookController < ApplicationController
  before_action :find_book, only: [:show]
  def index
    @supports = Supports::Book.new @book
    @books = @supports.category(params[:category]).nil? ? 
      Book.all : @supports.category(params[:category]).books
    if params[:category] && @supports.category(params[:category]).nil?
      flash[:warning] = t "not_category"
      redirect_to book_index_path
    end
  end

  def show
  end

  private
  def book_params
    params.require(:book).permit :title, :author, :images, :category_id
  end
  def find_book
    @book = Book.find_by id: params[:id]
    if @book.nil?
      flash[:warning] = t("controller.book.not_found_book")
      redirect_to book_index_path
    end
  end
end
