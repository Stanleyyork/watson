class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
  end

  def twitter 
    @twitter_username = params['user']['twitter_username']
    @user = current_user
    @user.twitter_username = @twitter_username
    @user.save
    if Channel.where(user_id: @user.id).where(name: "twitter").first.nil?
      TwitterInfo.new.public_tweets(@twitter_username, current_user.id)
      flash[:notice] = "Stored tweets successfully!"
      redirect_to edit_user_path(current_user)
    else
      flash[:notice] = "Already stored tweets"
      redirect_to edit_user_path(current_user)
    end
  end

  def facebook
    @graph = Koala::Facebook::API.new(current_user.facebook_access_token)
    if(Channel.where(user_id: current_user.id).first.nil?)
      feed = @graph.get_connections("me", "feed")
      feed.each do |f|
        puts f
        c = Channel.new(content: f['message'])
        c.user_id = current_user.id
        c.name = "Facebook"
        c.date = f['created_time']
        c.num_entries = 1
        c.save
      end
    end
    redirect_to edit_user_path(current_user)
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:name,:email,:username)
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else 
      flash[:notice] = @user.errors.map{|k,v| "#{k} #{v}".capitalize}
      redirect_to edit_user_path
    end
  end

  def edit
    @user = current_user
    @twitter_count = Channel.where(user_id: current_user.id).where(name: "twitter").count
    @facebook_count = Channel.where(user_id: current_user.id).where(name: "Facebook").count
  end

  def destroy
    if @user.id == current_user.id
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to '/signup'
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/settings'
    else
      flash[:notice] = user.errors.map{|k,v| "#{k} #{v}".capitalize}
      redirect_to '/signup'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end
end
