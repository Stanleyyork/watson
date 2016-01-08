class ChannelsController < ApplicationController

	def booksIndex
		@books = Channel.where(name: book)
	end

end
