class User < ActiveRecord::Base
	has_secure_password(validations: false)
  # From paperclip
  has_attached_file :avatar, 
                    styles: { medium: "300x300>", thumb: "100x100>" }, 
                    :default_url => "assets/images/WATSON_NO_PIC.png",
                    :storage => :dropbox,
                    :dropbox_credentials => {app_key: ENV['DROPBOX_KEY'], 
                                            app_secret: ENV['DROPBOX_SECRET'], 
                                            access_token: ENV['DROPBOX_ACCESS_TOKEN'], 
                                            access_token_secret: ENV['DROPBOX_ACCESS_TOKEN_SECRET'], 
                                            user_id: ENV['USER_ID'], access_type: "app_folder"}
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates_confirmation_of :password, unless: -> { from_omniauth? }
  validates_presence_of :password, :on => :create, unless: -> { from_omniauth? }

	validates_presence_of :email, :notice => "Please include email", unless: -> { from_omniauth? }
	validates_uniqueness_of :email, :notice => "Email already taken", unless: -> { from_omniauth? }
	validates :username, length: {minimum: 3, maximum: 15}, :uniqueness => { :case_sensitive => false},
	  format: {
	    with: /\A[a-zA-Z0-9_-]+\z/,
	    message: 'Must be formatted correctly (no spaces)'
	  }, unless: -> { from_omniauth? }

  def self.from_omniauth(auth)
    unless auth.nil?
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
  end

  private

  def from_omniauth?
    provider && uid
  end

end
