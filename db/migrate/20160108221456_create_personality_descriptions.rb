class CreatePersonalityDescriptions < ActiveRecord::Migration
  def change
    create_table :personality_descriptions do |t|
      t.string :category
      t.string :subcategory
      t.string :attribute_name
      t.string :low_term
      t.string :low_description
      t.string :high_term
      t.string :high_description

      t.timestamps null: false
    end
  end
end
