class PersonalitiesController < ApplicationController
	require './lib/tasks/PersonalityAPI'
	
	def new
		#sample test
		url = "http://www.gutenberg.org/files/1342/1342-h/1342-h.htm"
		url2 = "http://www.gutenberg.org/files/2701/2701.txt"
		PersonalityAPICall.new.Call(17,"book",2015, "Pride And Prejudice" ,url)
	end

	def create
	end
end
