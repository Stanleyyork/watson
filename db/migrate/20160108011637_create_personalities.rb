class CreatePersonalities < ActiveRecord::Migration
  def change
    create_table :personalities do |t|
      t.string :category
      t.string :subcategory
      t.string :attribute
      t.float :percentage
      t.float :sampling_error
      t.string :channel_name
      t.integer :user_id
      t.integer :channel_id
      t.date :date

      t.timestamps null: false
    end
  end
end
