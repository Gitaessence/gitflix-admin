class ApplicationController < ActionController::Base
  protect_from_forgery

  def access_denied(exception)
    print "#############{exception.message}"
    redirect_to admin_categories_path
  end
end
