class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @title = params[:relation]
    @user = User.find_by id: params[:user_id]
    if @user
      @users = @user.send(@title).paginate page: params[:page]
      render "users/show_follow"
    else
      flash[:danger] = t "controllers.relationship.not_found_user"
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      @relationship = current_user.active_relationships
        .find_by followed_id: @user.id
      redirect_to @user
    else
      flash[:danger] = t "controllers.relationship.not_found_user_follow"
      redirect_to root_path
    end
  end

  def destroy
    relationship = Relationship.find_by(id: params[:id]).followed
    if relationship
      @relation = current_user.active_relationships.build
      current_user.unfollow relationship
      @user = User.find_by id: relationship.id
      unless @user
        flash[:danger] = t "controllers.relationship.not_found_user"
        redirect_to root_url
      end
      redirect_to @user
    else
      flash[:danger] = t "controllers.relationship.not_followed"
      redirect_to root_url
    end
  end
end
