class AddFacebookPostsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :facebook_posts, :string
  end
end
