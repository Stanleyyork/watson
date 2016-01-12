class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.string :label
      t.string :relevance
      t.string :website
      t.string :dbpedia
      t.string :freebase
      t.string :yago
      t.integer :user_id
      t.string :channel_name
      t.string :title
      t.string :year

      t.timestamps null: false
    end
  end
end
