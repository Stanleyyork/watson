class AddYearToPersonality < ActiveRecord::Migration
  def change
    add_column :personalities, :year, :integer
  end
end
