class CommentsController < ApplicationController

  before_action :find_comment, only: [:update, :destroy]

  def create
    @comment = current_user.comments.new comment_params
    unless @comment.save
      flash[:danger] = t "comments.not_save"
    end
    respond_to do |format|
      format.html {redirect_to @comment.review.book}
      format.js
    end
  end

  def update
    unless @comment.update_attributes comment_params
      flash[:danger] = t "comments.not_update"
    end
    respond_to do |format|
      format.html {redirect_to @comment.review.book}
      format.js
    end
  end
  
  def destroy
    unless @comment.destroy
      flash[:danger] = t "comments.not_delete"
    end
    respond_to do |format|
      format.html {redirect_to @comment.review.book}
      format.js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :review_id, :user_id, :comment
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "comments.not_found_comment"
    end
  end
end
