class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

  def error_not_found
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
