class RequestsController < ApplicationController
  before_action :logged_in_user
  
  def index
    @requests = current_user.requests.sort_by_created_at
  end
  
  def new 
    @request = Request.new
  end

  def create
    @request = current_user.requests.new request_params
    if @request.save
      flash[:info] = t "controllers.request.create"
      redirect_to requests_path
    else
      flash.now[:danger] = t "controllers.request.not_create"
      render :new
    end
  end

  def destroy
    @request = Request.find_by id: params[:id]
    @request.destroy
    respond_to do |format|
      format.html {redirect_to requests_path}
      format.js
    end
  end

  private
  def request_params
    params.require(:request).permit :name_book 
  end
end
