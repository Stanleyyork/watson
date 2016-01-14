class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :update, :destroy]
  


  def show
    @user = User.find_by_username(params[:username]) || User.find_by_username(params[:username].capitalize)
    if(Personality.where(user_id: @user.id).count > 0)
      @big_5 = Personality.where(user_id: @user.id).where(category: "Big 5").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
      @needs = Personality.where(user_id: @user.id).where(category: "Needs").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
      @values = Personality.where(user_id: @user.id).where(category: "Values").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
      @docSentiment = Topic.where(user_id: @user.id).where(name: "Document Sentiment").pluck(:relevance)[0].to_f
      @docSentimentLabel = Topic.where(user_id: @user.id).where(name: "Document Sentiment").pluck(:label)[0]
      if @docSentiment != 0.0
        @samplechart = LazyHighCharts::HighChart.new('graph') do |f|
          f.series(:name=>'John', :data=>[@docSentiment], :color=> '#E23246')
          f.options[:xAxis][:reversed] = false
          f.options[:xAxis][:labels] = { enabled:false }
          f.options[:yAxis][:labels] = { enabled:false }
          f.options[:yAxis][:max] = 1
          f.options[:yAxis][:min] = -1
          f.options[:yAxis][:tickInterval] = 1
          f.options[:legend][:enabled] = false
          f.chart({:defaultSeriesType=>"bar", :backgroundColor=>'#FCEDED', :height=>'125', :width=>'1000'})
        end
    else
      flash[:notice] = "Analyze tweets first"
      redirect_to edit_user_path(current_user.username)
    end
  end

  def analyze_personality
    if(!Channel.where(name: "twitter").where(user_id: current_user.id).empty?)
      Personality.where(user_id: current_user.id).where(channel_name: "twitter").delete_all
      Personality.personality(current_user.id, "twitter", "#{current_user.name}'s Twitter Account")
      Topic.where(user_id: current_user.id).where(channel_name: "twitter").delete_all
      Topic.alchemy(current_user.id, "twitter", "#{current_user.name}'s Twitter Account")
    else
      flash[:notice] = "No twitter content to analyze"
    end
    redirect_to user_path(current_user.username)
  end

  def twitter 
    @twitter_username = params[:twitter_username]
    @user = current_user
    @user.twitter_username = @twitter_username
    @user.save
    if Channel.where(user_id: @user.id).where(name: "twitter").first.nil?
      TwitterInfo.new.public_tweets(@twitter_username, current_user.id)
      render :text => "Stored tweets successfully!"
    else
      flash[:notice] = "Already stored tweets"
      redirect_to edit_user_path(current_user.username)
    end
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:name,:email,:username, :avatar)
    if @user.update_attributes(user_params)
      flash[:notice] = "Updated!"
      redirect_to edit_user_path
    else 
      flash[:notice] = @user.errors.map{|k,v| "#{k} #{v}".capitalize}
      redirect_to edit_user_path
    end
  end

  def edit
    @user = current_user
    @twitter_count = Channel.where(user_id: current_user.id).where(name: "twitter").count
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
    if current_user
      redirect_to '/settings'
    end
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
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation, :avatar)
  end
end
