class CreatePersonalityDualDescriptions < ActiveRecord::Migration
  def change
    create_table :personality_dual_descriptions do |t|
      t.string :category
      t.string :primary_subcategory
      t.string :secondary_subcategory
      t.string :primary_high_secondary_high
      t.string :primary_high_secondary_low
      t.string :primary_low_secondary_high
      t.string :primary_low_secondary_low

      t.timestamps null: false
    end
  end
end
