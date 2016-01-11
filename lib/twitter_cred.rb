class TwitterInfo

  # Twitter API client setup
  
  def public_tweets(username, user_id)
    puts 'public_tweets'
    client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWIT_CONSUMER_KEY']
      config.consumer_secret = ENV['TWIT_CONSUMER_SECRET']
      config.access_token = ENV['TWIT_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWIT_ACCESS_TOKEN_SECRET']
    end

    # Recursively fetch all tweets
    
    def collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end

    def client.get_all_tweets(user, user_id)
      collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        user_timeline(user, options)
      end
    end
    
    results = client.get_all_tweets(username, user_id)
    save_data(results, user_id)
  end

  # Save each individual tweet to db

  def save_data(results, user_id)
    puts 'save_data'
    results.each do |tweet|
      puts tweet
      @savetweet = Channel.new
      @savetweet.content = tweet.text 
      @savetweet.user_id = user_id
      @savetweet.date = tweet.created_at
      @savetweet.name = "twitter"
      @savetweet.subname = "account: " + tweet.user.screen_name
      @savetweet.year = tweet.created_at.year
      @savetweet.num_entries = 1
      @savetweet.save
    end
  end
end


