require 'rubygems'
require 'net/http'
require 'uri'
require 'json'

class AlchemyAPI

	#Setup the endpoints
	@@ENDPOINTS = {}
	@@ENDPOINTS['sentiment'] = {}
	@@ENDPOINTS['sentiment']['url'] = '/url/URLGetTextSentiment'
	@@ENDPOINTS['sentiment']['text'] = '/text/TextGetTextSentiment'
	@@ENDPOINTS['sentiment']['html'] = '/html/HTMLGetTextSentiment'
	@@ENDPOINTS['concepts'] = {}
	@@ENDPOINTS['concepts']['url'] = '/url/URLGetRankedConcepts'
	@@ENDPOINTS['concepts']['text'] = '/text/TextGetRankedConcepts'
	@@ENDPOINTS['concepts']['html'] = '/html/HTMLGetRankedConcepts'
	@@ENDPOINTS['category'] = {}
	@@ENDPOINTS['category']['url']  = '/url/URLGetCategory'
	@@ENDPOINTS['category']['text'] = '/text/TextGetCategory'
	@@ENDPOINTS['category']['html'] = '/html/HTMLGetCategory'
	@@ENDPOINTS['language'] = {}
	@@ENDPOINTS['language']['url']  = '/url/URLGetLanguage'
	@@ENDPOINTS['language']['text'] = '/text/TextGetLanguage'
	@@ENDPOINTS['language']['html'] = '/html/HTMLGetLanguage'
	@@ENDPOINTS['text'] = {}
	@@ENDPOINTS['text']['url']  = '/url/URLGetText'
	@@ENDPOINTS['text']['html'] = '/html/HTMLGetText'
	@@ENDPOINTS['text_raw'] = {}
	@@ENDPOINTS['text_raw']['url']  = '/url/URLGetRawText'
	@@ENDPOINTS['text_raw']['html'] = '/html/HTMLGetRawText'
	@@ENDPOINTS['title'] = {}
	@@ENDPOINTS['title']['url']  = '/url/URLGetTitle'
	@@ENDPOINTS['title']['html'] = '/html/HTMLGetTitle'
	@@ENDPOINTS['combined'] = {}
	@@ENDPOINTS['combined']['url'] = '/url/URLGetCombinedData'
	@@ENDPOINTS['combined']['text'] = '/text/TextGetCombinedData'
	@@ENDPOINTS['combined']['html'] = '/html/HTMLGetCombinedData'
		
	@@BASE_URL = 'http://access.alchemyapi.com/calls'
	
	def initialize()
		@apiKey = "189f26e83318960f3460b1e00538825f585c94e9"
	end

	def sentiment(flavor, data, options = {})
		unless @@ENDPOINTS['sentiment'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'sentiment analysis for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['sentiment'][flavor], options)
	end

	def concepts(flavor, data, options = {})
		unless @@ENDPOINTS['concepts'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'concept tagging for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['concepts'][flavor], options)
	end

	def category(flavor, data, options = {})
		unless @@ENDPOINTS['category'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'text categorization for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['category'][flavor], options)
	end

	def language(flavor, data, options = {})
		unless @@ENDPOINTS['language'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'language detection for ' + flavor + ' not available' }
		end

		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['language'][flavor], options)
	end

	def text(flavor, data, options = {})
		unless @@ENDPOINTS['text'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'clean text extraction for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['text'][flavor], options)
	end

	def text_raw(flavor, data, options = {})
		unless @@ENDPOINTS['text_raw'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'raw text extraction for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['text_raw'][flavor], options)
	end

	def combined(flavor, data, options = {})
		unless @@ENDPOINTS['combined'].key?(flavor)
			return { 'status'=>'ERROR', 'statusInfo'=>'Combined data for ' + flavor + ' not available' }
		end
		#Add the URL encoded data to the options and analyze
		options[flavor] = data
		return analyze(@@ENDPOINTS['combined'][flavor], options)
	end

	private
	def analyze(url, options)
		#Insert the base URL
		url = @@BASE_URL + url
		#Add the API key and set the output mode to JSON
		options['apikey'] = @apiKey
		options['outputMode'] = 'json'
		uri = URI.parse(url)
		request = Net::HTTP::Post.new(uri.request_uri)
		request.set_form_data(options)
		# disable gzip encoding which blows up in Zlib due to Ruby 2.0 bug
		# otherwise you'll get Zlib::BufError: buffer error
		request['Accept-Encoding'] = 'identity'
		#Fire off the HTTP request
		res = Net::HTTP.start(uri.host, uri.port) do |http|
      		http.request(request)
    	end
		#parse and return the response
		return JSON.parse(res.body)
	end
end
if __FILE__==$0
  	# this will only run if the script was the main, not load'd or require'd
	if ARGV.length == 1
		if (ARGV[0].length == 40)
			puts 'Key: ' + ARGV[0] + ' was written to api_key.txt'
			puts 'You are now ready to start using AlchemyAPI. For an example, run: ruby example.rb'
			File.open('api_key.txt','w') {|f| f.write(ARGV[0]) }
		else
			puts 'The key appears to invalid. Please make sure to use the 40 character key assigned by AlchemyAPI'
		end
	end
end


class AlchemyAPICall

	def Call(user_id, channel_name, title, channel_url='')
		puts " alchemy Call()"

		begin

			if(channel_name.downcase == "book")
				body = channel_url
				text_or_url = "url"
				title += title + " url: " +  channel_url
			elsif(channel_name.downcase == "twitter" || channel_name == "Facebook")
				body = Channel.where(user_id: user_id).where(name: channel_name).pluck(:content).join(" ")
				text_or_url = "text"
			else
				return "Channel not recognized"
			end
			if(body.length != 0)
				combined = AlchemyAPI.new().combined(text_or_url, body, { 'extract'=>'category,concept,doc-sentiment' })
				if(JSON.parse(JSON.pretty_generate(combined))["status"] == "ERROR")
					puts "trying again..."
					combined = AlchemyAPI.new().combined(text_or_url, body, { 'extract'=>'category,concept,doc-sentiment' })
					if(JSON.parse(JSON.pretty_generate(combined))["status"] == "ERROR")
						puts "trying one more time..."
						combined = AlchemyAPI.new().combined(text_or_url, body, { 'extract'=>'category,concept,doc-sentiment' })
					end
				end
				results = JSON.parse(JSON.pretty_generate(combined))
				ParseAndSave(results, user_id, channel_name, title, channel_url)
			end

		rescue
			puts "User_id: #{user_id} rescued"
		end
	end

	def ParseAndSave(results, user_id, channel_name, title, channel_url)
		#Document Sentiment
		docSentiment = {
			name: "Document Sentiment",
			label: results['docSentiment']['type'],
			relevance: results['docSentiment']['score']
			}
		topicEntry = Topic.new(docSentiment)
		topicEntry.channel_name = channel_name
		topicEntry.title = title
		topicEntry.user_id = user_id
		topicEntry.save

		# Concepts
		results['concepts'].each do |r|
			concepts = {
				name: "Concepts",
				label: r['text'],
				relevance: r['relevance'],
				website: r['website'],
				dbpedia: r['dbpedia'],
				freebase: r['freebase'],
				yago: r['yago']
				}
			topicEntryb = Topic.new(concepts)
			topicEntryb.channel_name = channel_name
			topicEntry.title = title 
			topicEntryb.user_id = user_id
			topicEntryb.save
		end

		# Category
		category = {
			name: "Category",
			label: results['category'],
			relevance: results['score']
			}
		topicEntryc = Topic.new(category)
		topicEntryc.channel_name = channel_name
		topicEntry.title = title
		topicEntryc.user_id = user_id
		topicEntryc.save
	end
end