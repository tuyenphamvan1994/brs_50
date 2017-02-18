class FavoriteBooksController < ApplicationController
  before_action :find_book
  before_action :find_favorite_book, only: [:destroy]

  def create
    @favorite_book = current_user.favorite_books.build favorite_book_params
    @favorite_book.save
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  def destroy
    unless @favorite_book.destroy
      flash[:warning] = t "controller.favorite_book.not_destroy"
    end
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  private
  def favorite_book_params
    params.require(:favorite_book).permit :book_id, :user_id
  end

  def find_book
    @book = Book.find_by id: favorite_book_params[:book_id]
    unless @book
      flash[:danger] = t "controller.book.not_found_book"
      redirect_to books_path
    end
  end

  def find_favorite_book
    @favorite_book = FavoriteBook.find_by id: params[:id]
    unless @favorite_book
      flash[:warning] = t "controller.favorite_book.not_find_favorite"
      redirect_to @book
    end
  end
end
