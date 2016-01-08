class RemoveColumns < ActiveRecord::Migration
  def self.up
  	remove_column :personalities, :attribute
  end
end
