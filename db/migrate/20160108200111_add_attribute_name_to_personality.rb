class AddAttributeNameToPersonality < ActiveRecord::Migration
  def change
    add_column :personalities, :attribute_name, :string
  end
end
