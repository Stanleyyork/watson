class ChannelsController < ApplicationController

	def booksIndex
		@book = Channel.where(user_id: current_user.id).where(name: "book").first
		if @book.nil?
			@book = Channel.new
		end
	end

	def booksUpdate
		@book = Channel.where(user_id: current_user.id).where(name: "book").first
		if @book.nil?
			@book = Channel.new(name: "book")
		end
		if @book.update_attributes(book_params)
      	flash[:notice] = "Updated!"
		redirect_to '/settings'
		end
	end

	private

	def book_params
		params.require(:channel).permit(:title, :url)
	end

end
