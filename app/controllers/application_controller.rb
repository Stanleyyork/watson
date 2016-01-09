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

  def homepage
    @oauth = Koala::Facebook::OAuth.new(ENV["FB_APP_ID"], ENV["FB_APP_SECRET"], "http://localhost:3000/")
    @facebook_login_url = @oauth.url_for_oauth_code(:permissions => "user_posts")
    if params.has_key? :code
      access_token = @oauth.get_access_token(params[:code])
      @graph = Koala::Facebook::API.new(access_token)
      feed = @graph.get_connections("me", "feed") 
      feed_length = (feed.map { |post| (post["message"] || "").length }).sum
      puts "total feed length = " + feed_length.to_s
    end
    render template: "layouts/homepage.html.erb"
  end
  
end
