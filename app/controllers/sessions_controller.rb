class SessionsController < ApplicationController

  def new
    @oauth = Koala::Facebook::OAuth.new(ENV["FB_APP_ID"], ENV["FB_APP_SECRET"], "http://localhost:3000/")
    @facebook_login_url = @oauth.url_for_oauth_code(:permissions => "user_posts")
  end

  def create
    if params.has_key? :email
      user = User.find_by_email(params[:email])
      # If the user exists AND the password entered is correct.
      if user && user.authenticate(params[:password])
        # Save the user id inside the browser cookie. This is how we keep the user 
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to '/'
      else
      # If user's login doesn't work, send them back to the login form.
        redirect_to '/login'
      end
    else
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      access_token = user.oauth_token
      @graph = Koala::Facebook::API.new(access_token)
      feed = @graph.get_connections("me", "feed")
      puts user.to_yaml
      user.update_attribute(:facebook_posts, (feed.map { |post| (post["message"] || "") }).join(" "))
      puts user.to_yaml
      feed_length = user.facebook_posts.length
      puts "total feed length = " + feed_length.to_s
      if user.save
        redirect_to '/'
      else
        puts "User couldn't save"
        redirect_to '/'
      end
    end  
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
