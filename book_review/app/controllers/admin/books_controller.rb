class Admin::BooksController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_book, except: [:index, :new, :create]
  before_action :load_categories, except: [:index, :show, :destroy]

  def index
    @books = Book.search_by_title(params[:search]).paginate page: params[:page]
  end

  def new
    @book = Book.new
  end
	
  def create
    @book = Book.new book_params
    if @book.save
      flash.now[:success] = t "controllers.admin.books.create"
      redirect_to admin_book_path @book
    else
      flash.now[:danger] = t "controllers.admin.books.not_new"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @book.update_attributes book_params
      flash.now[:success] = t "controllers.admin.books.update"
      redirect_to admin_books_path
    else
      flash.now[:danger] = t "controllers.admin.books.not_update"
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to admin_books_path
  end
    
  private
  def load_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash.now[:danger] = t "controllers.admin.books.not_found"
      redirect_to admin_books_path
    end
  end
  
  def load_categories
    @categories = Category.all.map{|category| [category.name, category.id]}
    unless @categories
      flash.now[:danger] = t "controllers.admin.books.not_found_category"
      redirect_to admin_books_path
    end
  end

  def book_params
    params.require(:book).permit :title, :description, 
      :author, :category_id, :image, :number_page, :publish_date
  end
end
