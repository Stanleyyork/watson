class PersonalityDualDescriptionsController < ApplicationController
  def new
  	personality_dual_description = PersonalityDualDescription.new
  end

  def create
  	pdd_params = params.require(:personality_dual_description).permit(:category, :attribute_name, :high_description)
  	puts pd_params
  	personality_dual_description = PersonalityDualDescription.new(pdd_params)
    if personality_dual_description.save
    	flash[:notice] = "Saved"
     	redirect_to '/personality_dual_descriptions/new' 
    else
    	flash[:notice] = "Not Saved"
     	redirect_to '/personality_dual_descriptions/new'
    end
  end
end
