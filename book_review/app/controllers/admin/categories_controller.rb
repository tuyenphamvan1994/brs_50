class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :verify_admin
  before_action :load_category, only: [:edit, :update, :destroy]
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controller.categories.create"
      redirect_to admin_categories_path
    else
      render :new
    end
  end
  
  def edit 
  end 
  
  def update
    if @category.update_attributes category_params
      flash[:success] = t "controller.categories.update"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end
 
  def destroy
    @category.destroy
    flash[:success] = t "controller.categories.delete"
    redirect_to admin_categories_path
  end
 
  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "controller.categories.found"
      redirect_to root_path
    end
  end

  def category_params
    params.require(:category).permit :name
  end
 end
