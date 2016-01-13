class Personality < ActiveRecord::Base
	require './lib/tasks/PersonalityAPI'

	def self.personality(user_id, channel_name, title, channel_url='')
		PersonalityAPICall.new.Call(user_id, channel_name, title, channel_url)
	end

	def book_import(user_id, channel_name, year, title, channel_url='')
		Personality.personality.where()  do |book|
			book.user_id = nil
			book.channel_name = Book
			book.year = nil
			book.title = ""
			book.channel_url = nil




		end
	end


end
