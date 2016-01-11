class Tweets
  def self.public_tweets
    client.user_timeline('stanleyyork', exclude_replies: true, include_rts: false)
  end
  
  def self.client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWIT_CONSUMER_KEY']
      config.consumer_secret = ENV['TWIT_CONSUMER_SECRET']
      config.access_token = ENV['TWIT_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWIT_ACCESS_TOKEN_SECRET']
    end
  end
end