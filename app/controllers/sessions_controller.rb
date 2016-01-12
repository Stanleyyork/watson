class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to '/settings'
    end
    @oauth = Koala::Facebook::OAuth.new(ENV["FB_APP_ID"], ENV["FB_APP_SECRET"], "http://localhost:3000/")
    @facebook_login_url = @oauth.url_for_oauth_code(:permissions => "user_posts")
  end

  def create
    if params.has_key? :user and params[:user].has_key? :email
      user = User.find_by_email(params[:user][:email])
      # If the user exists AND the password entered is correct.
      if user && user.authenticate(params[:user][:password])
        # Save the user id inside the browser cookie. This is how we keep the user 
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to '/settings'
      else
      # If user's login doesn't work, send them back to the login form.
        flash[:notice] = "Wrong email or password"
        redirect_to '/login'
      end
    elsif(!current_user)
      user = User.from_omniauth(env["omniauth.auth"])
      if user.nil?
        flash[:notice] = "Facebook login failed"
        redirect_to '/login'
      end
      session[:user_id] = user.id
      access_token = user.oauth_token
      user.facebook_access_token = access_token
      if user.save
        redirect_to edit_user_path(current_user)
      else
        puts "User couldn't save"
        redirect_to '/login'
      end
    else
      puts "User already exists, but no facebook info"
      @user = current_user
      auth = env["omniauth.auth"]
      User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        @user.provider = auth.provider
        @user.facebook_access_token = auth.credentials.token
        puts @user.facebook_access_token
        @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        @user.save
      end
      redirect_to edit_user_path(current_user)
    end  
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
