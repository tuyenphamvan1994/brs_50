class StaticPagesController < ApplicationController
  def show
    if valid_page?
      if logged_in?
        redirect_to books_path
      else
        render template: "static_pages/#{params[:page]}"
      end
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private
  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/static_pages/#{params[:page]}.html.erb"))
  end
end
