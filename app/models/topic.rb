class Topic < ActiveRecord::Base
	require './lib/tasks/AlchemyAPI'

	def self.alchemy(user_id, channel_name, title, channel_url='')
		AlchemyAPICall.new.Call(user_id, channel_name, title, channel_url)
	end
end
