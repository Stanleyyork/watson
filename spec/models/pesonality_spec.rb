require 'rails_helper'
require './lib/tasks/PersonalityAPI'

RSpec.describe Personality, type: :model do

	describe "Personality API" do

		personality_count = Personality.count
	  	url = "http://www.gutenberg.org/files/1342/1342-h/1342-h.htm"
		PersonalityAPICall.new.Call(1,"book",2015, "Pride And Prejudice", url)

		it "should save at least one entry" do
			expect(Personality.count).to be > personality_count
		end

		it "should have no NIL titles" do
			expect(Personality.where(title: nil).count).to eq(0)
		end

		it "should have no NIL user_ids" do
			expect(Personality.where(user_id: nil).count).to eq(0)
		end

		it "should have no NIL years" do
			expect(Personality.where(year: nil).count).to eq(0)
		end

		it "should have no NIL channel_names" do
			expect(Personality.where(channel_name: nil).count).to eq(0)
		end

		it "should have no NIL categories" do
			expect(Personality.where(category: nil).count).to eq(0)
		end

		it "should have no NIL percentage" do
			expect(Personality.where(percentage: nil).count).to eq(0)
		end

		it "should have no NIL sampling_errors" do
			expect(Personality.where(sampling_error: nil).count).to eq(0)
		end

	end
end

		
