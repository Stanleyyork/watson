class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :category
      t.integer :user_id
      t.date :date
      t.text :content
      t.integer :personality_id
      t.string :name
      t.string :subname
      t.integer :num_entries
      t.string :url
      t.string :image_url

      t.timestamps null: false
    end
  end
end
