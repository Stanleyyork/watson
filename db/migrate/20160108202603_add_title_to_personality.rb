class AddTitleToPersonality < ActiveRecord::Migration
  def change
    add_column :personalities, :title, :string
  end
end
