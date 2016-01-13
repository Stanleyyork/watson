class UsersController < ApplicationController
  require 'json'
  require './lib/tasks/PersonalityAPI'
  require 'measurable'

  before_filter :authorize, only: [:edit, :update, :destroy]
  
  def show
    if params.has_key?(:username)
      @user = User.find_by_username(params[:username]) || User.find_by_username(params[:username].capitalize)
    elsif params.has_key?(:id)
      @user = User.find_by_id(params[:id])
    else
      redirect_to '/'
    end
    puts @user.to_yaml
    @big_5 = Personality.where(user_id: @user.id).where(category: "Big 5").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
    @needs = Personality.where(user_id: @user.id).where(category: "Needs").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
    @values = Personality.where(user_id: @user.id).where(category: "Values").group(:attribute_name).average(:percentage).sort_by{|k,v| v}
    combination = [].concat(@big_5).concat(@needs).concat(@values)
    puts "#{combination.length} user things:"
    puts combination.to_yaml
    key_ordering = combination.map{ |pair| pair[0] }
    user_vector = combination.map{ |pair| pair[1] }
    books = [
      { :name => 'Alice in Wonderland', :filename => 'alice.json'},
      { :name => 'Dracula', :filename => 'dracula.json'},
      { :name => 'Adventures of Huckleberry Finn', :filename => 'huck.json'},
      { :name => 'Pride and Prejudice', :filename => 'pride.json'},
      { :name => 'Grimms Fairy Tales', :filename => 'grimm.json' },
      { :name => 'War and Peace', :filename => 'war.json'},
      { :name => 'Metamorphosis', :filename => 'metamorphosis.json'}
    ]
    sorted_books = books.sort_by { |book|
      book_vector = book_vector(book[:filename], key_ordering)
      distance = -Measurable.cosine_distance(user_vector, book_vector)
      puts "distance to #{book}: #{distance}"
      distance
    }
    puts sorted_books
    @closest_book = sorted_books[0][:name]
  end

  def book_vector(filename, key_ordering)
    book_file = File.read("#{Rails.root}/data/#{filename}")
    book_tree = JSON.parse(book_file)
    book_personality = PersonalityAPICall.new.Parse(book_tree)
    book_personality_pairs = book_personality.map { |personality_part|
      [personality_part[:attribute_name], personality_part[:percentage]]
    }
    puts "#{book_personality_pairs.length} book things:"
    puts book_personality_pairs.to_yaml
    book_personality_lookup = Hash[book_personality_pairs]
    book_vector = key_ordering.map { |key| book_personality_lookup[key] || 0 }
    puts "book vector:"
    puts book_vector.to_yaml
    book_vector
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
    if(!Channel.where(name: "Facebook").where(user_id: current_user.id).empty?)
      Personality.where(user_id: current_user.id).where(name: "Facebook").delete_all
      Personality.personality(current_user.id, "Facebook", "#{current_user.name}'s Facebook Account")
      Topic.where(user_id: current_user.id).where(channel_name: "Facebook").delete_all
      Topic.alchemy(current_user.id, "Facebook", "#{current_user.name}'s Facebook Account")
    end
    redirect_to user_path(current_user)
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
    if(Channel.where(user_id: current_user.id).where(name: "Facebook").first.nil?)
      feed = @graph.get_connections("me", "feed")
      feed.each do |f|
        puts f
        c = Channel.new(content: f['message'])
        c.user_id = current_user.id
        c.name = "Facebook"
        c.date = f['created_time']
        c.year = (f['created_time'].to_s)[0..3]
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
