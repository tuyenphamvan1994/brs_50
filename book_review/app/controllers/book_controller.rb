class BookController < ApplicationController
  before_action :find_book, only: [:show]
  def index
    @categories = Category.all
    @category_id = params[:category].blank? ? nil : Category.find_by(name: params[:category]).id
    @books = @category_id.nil? ? Book.all : (Book.load_book_from_category_id @category_id)
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
