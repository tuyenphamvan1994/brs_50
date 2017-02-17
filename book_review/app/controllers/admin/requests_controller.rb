class Admin::RequestsController < ApplicationController
  before_action :logged_in_user, :verify_admin
  
  def index
    @requests = Request.all.sort_by_created_at
  end

  def update
    @request = Request.find_by id: params[:id]
    if @request.update_attributes status: params[:status]
      redirect_to admin_requests_path
    end
  end
end
