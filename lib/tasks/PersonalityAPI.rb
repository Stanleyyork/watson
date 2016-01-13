#use in other files: require './lib/tasks/PersonalityAPI'
require 'watson-api-client'

class PersonalityAPICall

	## EXAMPLES:
	# Personality.Call(1,"twitter",2014,"Stanley's Twitter Account")
	# Personalitiy.Call(17,"book",2015, "Pride and Prejudice", http://www.gutenberg.org/files/2701/2701.txt")
	# Personality.Call(6,"facebook", 2014, "Stanley's Facebook Account")

	def Call(user_id, channel_name, title, channel_url="")
		#user_id = 1 || 7 || etc. (user's id)
		#channel_name = Twitter || Facebook || Book || etc. (channel to analyze)
		#channel_url = "http://www.gutenberg.org/files/2701/2701.txt" - OPTIONAL unless Book
		personality = WatsonAPIClient::PersonalityInsights.new(:user=>"fa30e7e1-7922-432c-ba1f-5bcde7c12e4d",
		                                                   :password=>"GEyCx8gQf5kL",
		                                                   :verify_ssl=>OpenSSL::SSL::VERIFY_NONE)
		
		if(channel_name.downcase == "book")
			body = open(channel_url, :ssl_verify_mode=>OpenSSL::SSL::VERIFY_NONE)
		elsif(channel_name.downcase == "twitter" || channel_name == "Facebook")
			body = Channel.where(user_id: user_id).where(name: channel_name).pluck(:content).join(" ")
		else
			return "Channel not recognized"
		end
		if(body.length != 0)
			result = personality.profile(
			  'Content-Type'     => "text/plain",
			  'Accept'           => "application/json",
			  'Accept-Language'  => "en",
			  'Content-Language' => "en",
			  'body'             => body.gsub!(/[^0-9A-Za-z]/, ' ')
			  )
			ParseAndSave(JSON.parse(result.body), user_id, channel_name, title)
		end
	end

	def AnnotateAndSave(personalities, user_id, channel_name, title)
		not_saved_counter = 0
		saved_counter = 0
		total_counter = personalities.length
		channel_id_var = channel_name.downcase == "book" ? nil : Channel.find_by_name(channel_name).id
		other_attributes = {channel_name: channel_name, title: title, user_id: user_id}
		personalities.each do |personality|
			personalityEntry = Personality.new(big_5_json_object)
			personalityEntry.attributes = other_attributes
			personalityEntry.save ? saved_counter += 1 : not_saved_counter += 1
		end
		puts "COUNTER - Big 5 // Saved: #{saved_counter}, Not Saved: #{not_saved_counter}, total: #{total_counter}"
	end

	def Parse(json_results)
		results = []
		
		# Set count values of each category groupings
		needs_attribute_count = json_results['tree']['children'][1]['children'][0]['children'].count
		values_attribute_count = json_results['tree']['children'][2]['children'][0]['children'].count

		# Loops through Big 5 and saves them
		(0..4).each do |big_5_trait|
			(0..5).each do |attrib_number|
				attrib_object = json_results['tree']['children'][0]['children'][0]['children'][big_5_trait]['children'][attrib_number]
				results << {category: json_results['tree']['children'][0]['name'],
							 subcategory: json_results['tree']['children'][0]['children'][0]['children'][0]['name'],
							 attribute_name: attrib_object['name'],
							 percentage: attrib_object['percentage'],
							 sampling_error: attrib_object['sampling_error']}
			end
		end

		# Loops through Needs and Values and saves them
		(1..2).each do |need_or_value|
			needs_values_attribute_count = need_or_value > 1 ? values_attribute_count : needs_attribute_count
			(0..needs_values_attribute_count-1).each do |attrib|
				attrib_object = json_results['tree']['children'][need_or_value]['children'][0]['children'][attrib]
				results << {category: json_results['tree']['children'][need_or_value]['name'],
									 attribute_name: attrib_object['name'],
									 percentage: attrib_object['percentage'],
									 sampling_error: attrib_object['sampling_error']}
			end
		end

		results
	end

	def ParseAndSave(json_results, user_id, channel_name, title)
		personalities = Parse(json_results)
		AnnotateAndSave(personalities, user_id, channel_name, title)
	end

end