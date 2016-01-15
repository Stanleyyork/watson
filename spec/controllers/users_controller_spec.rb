require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "Login (new)" do
		it "Assigns @user for new" do
			user = User.new
			get :new
			expect(assigns(:user).id).to eq(nil)
	    end
	end

	describe "Create user (create)" do
		it "Assigns current user session" do
			user = User.create
			expect(session[:user_id]).to eq(user.id)
		end
	end
	
	describe "Profile page (show)" do
	    it "Assigns user" do
			user = User.create(username: "johnsmith", email: "johnsmith@gmail.com", password: "abc895def241")
			Personality.create(user_id: user.id)
			get :show, username: user.username
			expect(assigns(:user)).to eq(user)
	    end

	    it "Renders the show template" do
	    	user = User.create(username: "jakesmith", email: "jakesmith@gmail.com", password: "abc895def241")
	    	Personality.create(user_id: user.id)
	    	get :show, username: 'jakesmith'
	    	expect(response).to render_template(:show)
	    end

	    it "Redirects to settings page if no Personality traits" do
	    	user = User.create(username: "janesmith", email: "janesmith@gmail.com", password: "abc895def241")
	    	current_user = user
	    	get :show, username: 'janesmith'
	    	expect(response).to render_template(:edit)
	    end
	end

end
