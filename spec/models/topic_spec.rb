require 'rails_helper'
require './lib/tasks/AlchemyAPI'

#bundle exec rspec spec

RSpec.describe Topic, type: :model do
	
	describe "Alchemy API" do

		topic_count = Topic.where(user_id: 119).count
	  	url = "http://www.gutenberg.org/files/1342/1342-h/1342-h.htm"
		AlchemyAPICall.new.Call(119, "book", "Pride And Prejudice", url)

		it "should save at least one entry" do
			expect(Topic.where(user_id: 119).count).to be > topic_count
		end

		it "should have no NIL names" do
			expect(Topic.where(user_id: 119).where(name: nil).count).to eq(0)
		end

		it "should have no NIL user_ids" do
			expect(Topic.where(user_id: nil).count).to eq(0)
		end

		it "should have no NIL channel_names" do
			expect(Topic.where(user_id: 119).where(channel_name: nil).count).to eq(0)
		end

		it "should have no NIL relevances" do
			expect(Topic.where(user_id: 119).where(name: "Document Sentiment").where(relevance: nil).count).to eq(0)
		end

		it "should have no NIL label" do
			expect(Topic.where(user_id: 119).where(label: nil).count).to eq(0)
		end

	end
end

		
