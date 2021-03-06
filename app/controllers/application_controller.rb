class ApplicationController < ActionController::Base
  require './lib/twitter_cred.rb'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/login' unless current_user
  end

  def about
    render template: "layouts/about.html.erb"
  end

  def homepage
    current_user
    render template: "layouts/homepage.html.erb"
  end
  
end
