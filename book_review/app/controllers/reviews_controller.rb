class ReviewsController < ApplicationController

  before_action :find_book
  before_action :find_review, only: [:edit, :update, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new review_params
    @review.book_id = @book.id
    if @review.save
      flash[:success] = t "controller.reviews.add"
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    else
      render :edit
    end
  end

  def destroy
    unless @review.destroy
      flash[:success] = t "controller.reviews.destroy"
    end
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  private
  def review_params
    params.require(:review).permit :rate, :review, :book_id, :user_id
  end
  
  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "controller.book.not_found_book"
      redirect_to books_path
    end
  end

  def find_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:warning] = t "controller.reviews.find"
      redirect_to @book
    end
  end
end
