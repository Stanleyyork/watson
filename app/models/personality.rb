class Personality < ActiveRecord::Base


	def self.personality(user_id, channel_name, year, title, channel_url)
		PersonalityAPICall.new.Call(user_id, channel_name, year, title, channel_url)
	end

end
