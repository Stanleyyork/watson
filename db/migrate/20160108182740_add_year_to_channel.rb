class AddYearToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :year, :integer
  end
end
