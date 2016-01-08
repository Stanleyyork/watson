class PersonalityDescriptionsController < ApplicationController
  def new
  	personality_description = PersonalityDescription.new
  end

  def create
  	pd_params = params.require(:personality_descriptions).permit(:category, :attribute_name, :high_description)
  	puts pd_params
  	personality_description = PersonalityDescription.new(pd_params)
    if personality_description.save
    	flash[:notice] = "Saved"
     	redirect_to '/personality_descriptions/new' 
    else
    	flash[:notice] = "Not Saved"
     	redirect_to '/personality_descriptions/new'
    end
  end
end
