class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :image_url
      t.integer :cook_time
      t.integer :prep_time
      t.integer :total_time
      t.string :author, limit: 128
      t.integer :nb_comments
      t.integer :people_quantity
      t.string :budget
      t.string :difficulty
      t.decimal :rate
      t.string :author_tip

      t.timestamps
    end
  end
end
