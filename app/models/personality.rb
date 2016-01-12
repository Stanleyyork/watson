class Personality < ActiveRecord::Base
	require './lib/tasks/PersonalityAPI'

	def self.personality(user_id, channel_name, title, channel_url='')
		PersonalityAPICall.new.Call(user_id, channel_name, title, channel_url)
	end

end
