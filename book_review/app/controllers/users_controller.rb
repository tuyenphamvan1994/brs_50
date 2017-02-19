class UsersController < ApplicationController
  before_action :load_user, only: [:show, :destroy] 
  
  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params 
    if @user.save
      flash[:success] = t "controller.user.create"
      redirect_to root_path
    else
      flash.now[:danger] = t "not_new_user"
      render :new
    end
  end

  def show
    if current_user.following? @user
      @relationship = current_user.active_relationships.find_by followed_id: @user.id
    else
      @relationship = current_user.active_relationships.build
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "controller.user.delete"
    redirect_to users_url
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controller.user.not_user"
      redirect_to root_path
    end
  end
  
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
