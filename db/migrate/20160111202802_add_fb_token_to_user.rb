class AddFbTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_access_token, :string
  end
end
