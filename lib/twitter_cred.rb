class TwitterInfo
  def public_tweets(username, user_id)
    puts 'public_tweets'
    client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWIT_CONSUMER_KEY']
      config.consumer_secret = ENV['TWIT_CONSUMER_SECRET']
      config.access_token = ENV['TWIT_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWIT_ACCESS_TOKEN_SECRET']
    end
    results = client.user_timeline(username, count: 200, include_rts: true)
    save_data(results, user_id)
  end
  
  # def self.client
  #   puts 'client'
  #   client ||= Twitter::REST::Client.new do |config|
  #     config.consumer_key = ENV['TWIT_CONSUMER_KEY']
  #     config.consumer_secret = ENV['TWIT_CONSUMER_SECRET']
  #     config.access_token = ENV['TWIT_ACCESS_TOKEN']
  #     config.access_token_secret = ENV['TWIT_ACCESS_TOKEN_SECRET']
  #   end
  # end

  def save_data(results, user_id)
    puts 'save_data'
    puts results
    results.each do |tweet|
      puts tweet
      puts '@savetweet = Channel.new'
      puts '@savetweet.content = ' + tweet.text
      puts '@savetweet.user_id = ' + user_id.to_s
      puts '@savetweet.date = ' + tweet.created_at.to_s
      puts '@savetweet.name = ' + "twitter"
      puts '@savetweet.subname = ' + "account:" + tweet.user.screen_name
      puts '@savetweet.year = ' + tweet.created_at.year.to_s
      puts '@savetweet.num_entries = ' + 1
      # @savetweet.save


      # @savetweet = Channel.new
      # @savetweet.content = tweet.text
      # @savetweet.user_id = user_id
      # @savetweet.date = tweet.
      # @savetweet.name = "Twitter"
      # @savetweet.subname = "account: #{username}"
      # @savetweet.year = tweet.
      # @savetweet.num_entries = 1
      # @savetweet.save 
    end
  end
end


