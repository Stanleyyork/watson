class User < ActiveRecord::Base
	has_secure_password
	validates_presence_of :email, :notice => "Please include email"
	validates_uniqueness_of :email, :notice => "Email already taken"
	validates :username, length: {minimum: 3, maximum: 15}, :uniqueness => { :case_sensitive => false},
	  format: {
	    with: /^[a-zA-Z0-9_-]+$/,
	    message: 'Must be formatted correctly (no spaces)'
	  }

end
